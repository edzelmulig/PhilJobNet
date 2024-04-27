import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:philjobnet/utils/dialog/custom_show_dialog.dart';

class JobPostedCard extends StatefulWidget {
  final dynamic jobPosting;
  final String jobID;

  const JobPostedCard({
    super.key,
    required this.jobPosting,
    required this.jobID,
  });

  @override
  State<JobPostedCard> createState() => _JobPostedCardState();
}

class _JobPostedCardState extends State<JobPostedCard> {
  final jobTypeColorMap = {
    "Part Time": const Color(0xFF3499da).withOpacity(0.3),
    "Full Time": const Color(0xFF279778).withOpacity(0.3),
    "Contract": Colors.orange.withOpacity(0.3),
    "Freelance": const Color(0xFF637a7a).withOpacity(0.3),
    "Internship": Colors.grey,
    "Temporary": const Color(0xFFF83333).withOpacity(0.3),
  };

  @override
  Widget build(BuildContext context) {
    // FORMAT THE TimeStamp INTO READABLE FORM
    final Timestamp datePosted = widget.jobPosting.datePosted;
    String formattedDate = DateFormat('MMMM d, y').format(datePosted.toDate());

    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFe8f3f8),
          foregroundColor: const Color(0xFFE5E7EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          padding: const EdgeInsets.only(right: 5),
          elevation: 0,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                jobID: widget.jobID,
                jobPosting: widget.jobPosting,
                backGroundColor: Colors.white,
              );
            },
          );
        },
        child: Row(
          children: <Widget>[
            // APPOINTMENT DETAILS
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CARD TITLE
                    _buildCardTitle(),
                    // SPACING
                    const SizedBox(height: 5),
                    // CARD SUBTITLE
                    _buildCardSubtitle(formattedDate),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET FOR CARD TITLE
  Widget _buildCardTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 90,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 2,
            bottom: 2,
          ),
          decoration: BoxDecoration(
            color: jobTypeColorMap[widget.jobPosting.jobType],
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              widget.jobPosting.jobType,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3C40),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Text(
              "${widget.jobPosting.companyName}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3C40),
              ),
            ),
          ),
        ),

        // ICON
        const Icon(
          Icons.more_vert_rounded,
          color: Color(0xFF3C3C40),
          size: 20,
        ),
      ],
    );
  }

  // WIDGET FOR CARD SUBTITLE
  Widget _buildCardSubtitle(String formattedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: SizedBox(
            child: Text(
              "${widget.jobPosting.jobCategory} | ${widget.jobPosting.jobPosition}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xFF3C3C40),
              ),
            ),
          ),
        ),
        Text(
          formattedDate,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.normal,
            color: Color(0xFF3C3C40),
          ),
        ),
      ],
    );
  }
}
