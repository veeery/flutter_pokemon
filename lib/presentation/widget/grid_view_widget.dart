import 'package:flutter/material.dart';
import 'package:flutter_pokemon/common/responsive.dart';

class GridViewWidget extends StatefulWidget {
  final Function event;
  final SliverGridDelegate? sliverGridDelegate;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final bool isLoadMoreFailed;

  const GridViewWidget({
    super.key,
    required this.event,
    required this.itemCount,
    required this.itemBuilder,
    this.sliverGridDelegate,
    this.shrinkWrap = true,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.isLoadMoreFailed = false,
  });

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController
      ..removeListener(onScroll)
      ..dispose();
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    // 0.9 can be used to modular as Offset scroll
    if (currentScroll >= maxScroll * 0.9) {
      // // in here u can add context read to triggered event of bloc
      widget.event();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);

    return GridView.builder(
      gridDelegate: widget.sliverGridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 10, mainAxisSpacing: 10),
      controller: scrollController,
      shrinkWrap: widget.shrinkWrap,
      padding: EdgeInsets.all(10),
      itemCount: (widget.isLoadingMore || widget.hasReachedMax) ? widget.itemCount + 1 : widget.itemCount + 1,
      itemBuilder: (context, index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        } else {
          return widget.isLoadMoreFailed
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: const Text('Failed due Connection'),
                  ),
                )
              : widget.isLoadingMore
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: const Center(child: Text('Loading.....')),
                      ),
                    )
                  : widget.hasReachedMax
                      ? Padding(
                          padding: EdgeInsets.all(2.h),
                          child: const Center(child: Text("There's no data anymore")),
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: GestureDetector(
                              onTap: () => widget.event(),
                              child: Container(
                                padding: EdgeInsets.all(1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey,
                                ),
                                child: const Text('Load More'),
                              ),
                            ),
                          ),
                        );
        }
      },
    );
  }
}
