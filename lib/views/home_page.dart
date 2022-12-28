import 'package:flutter/material.dart';
import 'package:hometask_lesson_9/models/companies.dart';
import 'package:hometask_lesson_9/models/vacancies.dart';
import 'package:hometask_lesson_9/services/get_companies_service.dart';
import 'package:hometask_lesson_9/services/get_jobs_service.dart';
import 'package:hometask_lesson_9/views/company_page.dart';
import 'package:hometask_lesson_9/views/job_page.dart';
import 'package:hometask_lesson_9/views/new_company_page_widget.dart';
import 'package:hometask_lesson_9/views/new_job_widget_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Job>? jobs = [];
  late List<Company>? companies = [];
  var isLoaded = false;

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    companies = await GetCompaniesService().getCompanies();
    jobs = await GetJobsService().getJobs();
    if (jobs != null && companies != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('hometask lesson 9'),
      ),
      floatingActionButton:
          _SelectFABwidget(currentPageIndex: currentPageIndex),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.document_scanner,
              size: 35,
            ),
            label: 'Vacancies',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.corporate_fare,
              size: 35,
            ),
            label: 'Companies',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
                itemCount: jobs!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'Position: ${jobs![index].title}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City: ${jobs![index].city}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Description: ${jobs![index].description}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Id: ${jobs![index].id}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'CompanyId: ${jobs![index].companyId}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JobPage(jobs: jobs![index]),
                          ));
                        },
                      ),
                    ),
                  );
                }),
          ),
          Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
                itemCount: companies!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'Name: ${companies![index].name}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Industry: ${companies![index].industry}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Description: ${companies![index].description}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Id: ${companies![index].id}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CompaniesPage(companies: companies![index]),
                          ));
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _SelectFABwidget extends StatelessWidget {
  const _SelectFABwidget({
    Key? key,
    required this.currentPageIndex,
  }) : super(key: key);

  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        if (currentPageIndex == 0) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NewJobPageWidget(),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NewCompanyPageWidget(),
          ));
        }
      },
    );
  }
}
