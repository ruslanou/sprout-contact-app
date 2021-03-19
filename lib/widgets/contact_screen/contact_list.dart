import 'package:flutter/material.dart';
import 'package:sprout_contact/models/user_model.dart';
import 'package:sprout_contact/service/user_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:sprout_contact/widgets/contact_screen/trailing_button.dart';
import 'package:sprout_contact/widgets/shared/featurenotready.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  UserService _userService = UserService();
  RxInt _selectedIndex = 100.obs;
  RxBool isTapped = false.obs;

  _changedIndex(index) {
    _selectedIndex.value = index;
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _userService.getallUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      // separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        User user = snapshot.data[index];
                        return Obx(
                          () =>
                              // () => GestureDetector(
                              //   onTap: () => _changedIndex(index),
                              //   child: Container(
                              //       color: _selectedIndex.value == index
                              //           ? Colors.purple.withOpacity(0.5)
                              //           : index % 2 == 0
                              //               ? Colors.grey.withOpacity(0.3)
                              //               : Colors.white,
                              //       height: 0.1.sh,
                              //       child: Row(
                              //         children: [
                              //           Expanded(
                              //             flex: 1,
                              //             child: Container(
                              //               height: 0.1.sh,
                              //               width: 0.3.sw,
                              //               child: Image.network(
                              //                 user.avatar,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             ),
                              //           ),
                              //           Expanded(
                              //             flex: 4,
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Text(
                              //                     '${user.firstName} ${user.lastName}'),
                              //                 SizedBox(height: 4),
                              //                 Text('${user.email}'),
                              //               ],
                              //             ),
                              //           ),
                              //           Expanded(
                              //             flex: 2,
                              //             child: _selectedIndex.value == index
                              //                 ? Container(
                              //                     padding:
                              //                         EdgeInsets.only(right: 10),
                              //                     alignment: Alignment.centerRight,
                              //                     width: 100,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         Icon(Icons.phone),
                              //                         Icon(Icons.message),
                              //                       ],
                              //                     ),
                              //                   )
                              //                 : Container(
                              //                     margin: EdgeInsets.all(20),
                              //                     height: 10,
                              //                     width: 10,
                              //                     decoration: BoxDecoration(
                              //                       color: Colors.green,
                              //                       shape: BoxShape.circle,
                              //                     ),
                              //                   ),
                              //           )
                              //         ],
                              //       )
                              Container(
                            height: 0.08.sh,
                            child: ListTile(
                              onTap: () => _changedIndex(index),
                              tileColor: _selectedIndex.value == index
                                  ? Colors.purple.withOpacity(0.5)
                                  : index % 2 == 0
                                      ? Colors.grey.withOpacity(0.3)
                                      : Colors.white,
                              contentPadding: EdgeInsets.zero,
                              hoverColor: Colors.green,
                              trailing: _selectedIndex.value == index
                                  ? Container(
                                      padding: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      width: 0.3.sw,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TrailingButton(Icon(Icons.phone)),
                                          TrailingButton(Icon(Icons.message)),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(20),
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                              shape: ContinuousRectangleBorder(),
                              title: Text('${user.firstName} ${user.lastName}'),
                              subtitle: Text('${user.email}'),
                              leading: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          child: Hero(
                                            tag: 'avatar',
                                            child: Container(
                                              width: 0.8.sw,
                                              height: 0.38.sh,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image:
                                                      NetworkImage(user.avatar),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: _selectedIndex.value == index
                                          ? ColorFilter.mode(
                                              Colors.black, BlendMode.dstATop)
                                          : ColorFilter.mode(
                                              Colors.purple.withOpacity(0.5),
                                              BlendMode.color,
                                            ),
                                      image: NetworkImage(user.avatar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: 300,
                                    maxWidth: 100,
                                    minHeight: 200,
                                    minWidth: 75,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //           ),
                          //    ),
                        );
                      });
                } else {
                  return Center(
                    child: Text(
                        'Something when wrong, check your internet connection'),
                  );
                }
              }
          }
          return Container();
        },
      ),
    );
  }
}
