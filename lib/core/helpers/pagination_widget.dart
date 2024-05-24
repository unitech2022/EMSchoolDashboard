import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

class PaginationWidget extends StatelessWidget {
  final int selectPage;
  final int totalPages;
  final Function(int page) onChange;

  const PaginationWidget(
      {super.key,
      required this.selectPage,
      required this.totalPages,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pagination(
            numOfPages: totalPages,
            selectedPage: selectPage,
            pagesVisible: 3,
            onPageChanged: onChange,
            nextIcon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 14,
            ),
            previousIcon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
              size: 14,
            ),
            activeTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            activeBtnStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
              ),
            ),
            inactiveBtnStyle: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              )),
            ),
            inactiveTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
