import '../common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class CachedImageNetworkWidget extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String? urlError;

  const CachedImageNetworkWidget(
      {Key? key, required this.url, this.fit, this.height, this.width, this.urlError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => _buildPlaceHolder(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
      fit: fit ?? BoxFit.cover,
    );
  }

  Widget _buildPlaceHolder() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: AppColors.colorGreyE2E0E0,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
      ).wrapSize(40, 40),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      color: AppColors.colorGreyF6F6F6,
      child: Image.asset(
        urlError ?? 'ic_not_found'.assetImagesPathPNG,
        fit: BoxFit.cover,
        color: AppColors.colorGreyBBBBBB,
      ),
    );
  }
}
