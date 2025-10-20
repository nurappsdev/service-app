
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'dart:convert';

import '../../../helpers/helpers.dart';
import '../../../models/models.dart';
import '../../../services/client_service.dart';  // Import JSON decoding

class JobListPage extends StatefulWidget {
  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  RxBool isJob = false.obs;
  int page = 1;  // Initial page
  int totalPage = 0;
  int currentPage = 0;
  int totalResult = 0;
  List<OpenAppliedJobResponseModel> openAppliedJobResponseModel = [];

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  // Function to fetch data
  Future<void> getJobAppliedData() async {
    try {
      if (page == 1) {
        isJob(true);
      }

      var response = await ApiClient.getData("/shift?type=open&page=$page");

      if (response.statusCode == 200 || response.statusCode == 201) {
        totalPage = jsonDecode(response.body['pagination']['totalPage'].toString()) ?? 0;
        currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
        totalResult = jsonDecode(response.body['pagination']['totalData'].toString()) ?? 0;

        var data = List<OpenAppliedJobResponseModel>.from(response.body["data"].map((x) => OpenAppliedJobResponseModel.fromJson(x)));

        if (page == 1) {
          openAppliedJobResponseModel.clear();  // Clear the list when the page is 1 (initial load)
        }

        openAppliedJobResponseModel.addAll(data);  // Add the new data to the list\
        isJob(false);  // Hide loading indicator
        _refreshController.refreshCompleted();  // Complete the refresh
        if (currentPage < totalPage) {
          _refreshController.loadComplete();  // Allow loading more data if there are more pages
        } else {
          _refreshController.loadNoData();  // No more data to load
        }
      } else {
        isJob(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
        _refreshController.refreshFailed();  // In case of error during refresh
      }
    } catch (e) {
      isJob(false);
      ToastMessageHelper.errorMessageShowToster("Error fetching data: $e");
      _refreshController.refreshFailed();  // Handle any errors during the refresh
    }
  }

  // Function to load more data when user reaches the end
  Future<void> _loadMore() async {
    if (page < totalPage) {
      page++;
      await getJobAppliedData();  // Load next page of data
    } else {
      _refreshController.loadNoData();  // No more data to load
    }
  }

  // Function to handle pull-to-refresh
  Future<void> _onRefresh() async {
    page = 1;  // Reset page to 1 for refreshing
    await getJobAppliedData();
  }

  @override
  void initState() {
    super.initState();
    getJobAppliedData();  // Load initial data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Job List")),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,  // Trigger on refresh
        onLoading: _loadMore,   // Trigger on load more
        child: ListView.builder(

          itemCount: openAppliedJobResponseModel.length,
          itemBuilder: (context, index) {
            final job = openAppliedJobResponseModel[index];
            return ListTile(

              title: Text(job.workType),
              subtitle: Text(job.address),
              onTap: () {
                // Navigate to job details or handle tap
              },
            );
          },
        ),
      ),
    );
  }
}
