import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widgets/todo_item.dart';

class Home extends StatefulWidget {
  
 Home({Key?key}): super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController =TextEditingController();

@override
  void initState() {
     _foundToDo = todoList;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
       appBar: _buildAppBar(),
       body: Stack(
         children: [
           Container(
            padding:const EdgeInsets.symmetric(horizontal: 20,vertical:15 ),
            child: Column(
              children: [
                serchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin:const EdgeInsets.only(bottom:20,
                        top:20 ),
                        child:const Text('todo',
                        style:TextStyle(
                          fontSize: 30,
                          fontWeight:  FontWeight.w500,
                        ),
                        ),
                      ),

                      for (ToDo todo in _foundToDo.reversed)
                       TodoItem( todo: todo,
                       onToDoChanged: _handleToDoChange,
                       onDeleteItem:  _deleteToDoItem,
                       ),
                       
                    ],
                  ))
              ],
            ),
           ),
           Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                     ),
                     child:  TextField(
                      controller:   _todoController,
                      decoration: InputDecoration(
                         hintText: 'Add news',
                         border: InputBorder.none
                         ),
                     ),
                ),
                ),

                Container(
                  margin:const EdgeInsets.only(
                    bottom: 20,
                    right: 20
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40),),
                    onPressed: (){
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
            ],),
           )
         ],
       ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState((){
      todo.isDone = !todo.isDone;
    });
    
  }
  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item)=> item.id == id);
    });
  }
  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results =[];
    if (enteredKeyword.isEmpty){
      results = todoList;
    }else{
      results = todoList
      .where((item) => item.todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase()))
      .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

    Widget serchBox() { 
    return  
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20) 
            ),
            child:  TextField(
              onChanged:   (value) => _runFilter(value) ,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search,
                color: tdBlack,
                size: 20,),
                prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                border: InputBorder.none,
                hintText: 'search',
                hintStyle: TextStyle(color: tdGrey),
              ),
            ),
          );
       
  }
}

 

  AppBar _buildAppBar(){
return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title:  Row(
        children: const[
          Icon(Icons.menu,
          color: tdBlack,
          size:30,
          ),
          
        ],
      ));
  }
    
    
  
