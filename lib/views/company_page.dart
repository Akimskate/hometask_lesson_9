import 'package:flutter/material.dart';
import 'package:hometask_lesson_9/models/companies.dart';
import 'package:hometask_lesson_9/models/vacancies.dart';
import 'package:hometask_lesson_9/services/get_jobs_by_id.dart';
import 'package:hometask_lesson_9/views/job_page.dart';

class CompaniesPage extends StatefulWidget {
  final Company companies;
  const CompaniesPage({
    Key? key,
    required this.companies,
  }) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  var isLoaded = false;
  late List<Job>? jobs = [];
  late int companyId;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final companyId = widget.companies.id;
    jobs = await GetJobsByIdService().getJobsById(companyId);
    if (jobs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Company details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Company name:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.companies.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Industry:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.companies.industry,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Description:',
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.companies.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: isLoaded,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
