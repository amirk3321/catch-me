import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String status;
  final String email;
  final String profile;
  final String uid;

  ProfilePage(
      {Key key, this.name, this.email, this.profile, this.status, this.uid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController;
  TextEditingController _statusController;

  String _name;
  String _status;

  String _image;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _statusController = TextEditingController(text: widget.status);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildProfileHeader(context),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_nameController.text.isNotEmpty ||
              _statusController.text.isNotEmpty ||
              _image != null) {
            BlocProvider.of<UserBloc>(context).dispatch(
                UpdateUser(user: User(profileUrl: _image,name: _nameController.text,status: _statusController.text,uid: widget.uid))
            );
          }
        },
        backgroundColor: Colors.orange,
        focusColor: Colors.white,
        label: Text(
          'save',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        icon: Icon(Icons.save),
        //child: Text('Save',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }

  Container buildProfileHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6 * 2,
      width: double.infinity,
      color: Colors.deepPurple,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 8 / 2,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      children: <Widget>[
                      Image.asset(
                          setProfile(),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                              icon: Icon(
                                Icons.mode_edit,
                                color: Colors.black,
                                size: 28,
                              ),
                              onPressed: () {
                                _imagePicker();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.name != null || widget.name == '' ? widget.name : '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                widget.status != null || widget.status == '' ? widget.status : 'status',
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon: Icon(
                  Icons.mode_edit,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  _inputDialog();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String setProfile() {
    if (_image == null && widget.profile == null && widget.profile == '') {
      return 'assets/default.png';
    } else if (_image != null) {
      return _image;
    } else if (widget.profile != null) {
      return widget.profile;
    }
    return 'assets/default.png';
  }

  void _inputDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Profile'),
            content: Container(
              width: MediaQuery.of(context).size.width / 6 * 5,
              height: MediaQuery.of(context).size.height / 8 * 3,
              child: Column(
                children: <Widget>[
                  _buildTextField(_nameController, 'Name', _name),
                  _buildTextField(_statusController, 'Status', _status),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _nameController.text = _nameController.text;
                    _statusController.text = _statusController.text;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Set',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  Container _buildTextField(TextEditingController controller, label, saveVal) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextFormField(
        onSaved: (val) => saveVal = val,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () => controller.text = '')),
      ),
    );
  }

  void _imagePicker() async {
    var galleryFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = galleryFile.path;
    });
  }
}
