
import 'package:emschool_dashboard/bloc/news_cubit/news_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/spacing.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';
import 'add_news_screen.dart';
import 'news_tables_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {

    super.initState();
    NewsCubit.get(context).getNews(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return state.getNewsState == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "قائمة الآخبار",
                        titleButton: "اضافة جديد",
                        onPress: () {
                          context.navigatePush(const AddNewsScreen());
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: NewsTablesWidget(
                          list: state.news!.items,
                          type: 0,
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
