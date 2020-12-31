import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo/Daos/PageDetails.dart';
import 'package:interview_demo/constants.dart';
import 'package:interview_demo/webViewWidget.dart';

class SearchItems  extends StatelessWidget {

PageDetails mpageDetails;

SearchItems(PageDetails pageDetails):super(key:Key(pageDetails.pageid.toString())){
     mpageDetails = pageDetails;
}


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        elevation: 5,
      child:
        InkWell(
          onTap:() {
         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>webViewWidget(mpageDetails.title, wiki_pedia_page.replaceAll("%s",mpageDetails.title ))));
          },
          hoverColor: Colors.lightBlue,
          child: Container(
            height: 100,
            child: Row(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: defaultTargetPlatform == TargetPlatform.iOS
                      ? 'assets/images/loading.gif'
                      : 'assets/images/loading_android2.gif',
                  image: mpageDetails.thumbnail != null ?  mpageDetails.thumbnail.source!= null ?mpageDetails.thumbnail.source:"":"",
                  height:150,
                  width: 100,
                  fit: BoxFit.fill
                ),
                SizedBox(
                  height: 5,
                  width: 15,
                ),
                Expanded(
                flex: 1,
                    child: Text(mpageDetails.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200),)),
                //Text(mpageDetails.terms != null ? mpageDetails.terms.description[0]:'')
              ],
            ),

      ),
        )),
    );
  }
}

