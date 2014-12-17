

#users
user1 = User.new(:email => 'bob@meigic.tw',:name =>'Bob',:password =>'Bob0000',:sign_in_count => 0)
user1.save

user2 = User.new(:email => 'alice@meigic.tw',:name =>'Alice',:password => 'Alice0000',:sign_in_count => 0)
user2.save

user3 = User.new(:email => 'john@meigic.tw',:name =>'John',:password => 'John0000',:sign_in_count => 0)
user3.save

user4 = User.new(:email => 'bruce@meigic.tw',:name =>'Bruce',:password => 'Bruce0000',:sign_in_count => 0)
user4.save

#board1
board1 =Board.new(:name => 'work1',:wip =>'10',:description =>'Board1 ,has two member,user3 and user4',:user_id => user1.id)
board1.save

user1.pin_boards << board1

# types of board1
b1type1 = Type.new(:name => 'normal',:color =>'#00ff00',:board_id => board1.id)
b1type1.save

b1type2 = Type.new(:name => 'emergency',:color =>'#00ff00',:board_id => board1.id)
b1type2.save

# board2
board2 =Board.new(:name => 'work2',:wip =>'10',:description =>'Board2,has tow member,user3 and user4',:user_id => user2.id)
board2.save

#types of board2
b2type1 = Type.new(:name => 'normal',:color =>'#00ff00',:board_id => board2.id)
b2type1.save

b2type2 = Type.new(:name => 'emergency',:color =>'#00ff00',:board_id => board2.id)
b2type2.save


#member of board1
member1 = BoardMember.new(:board_id => board1.id,:user_id => user3.id,:permission => 1)
member1.save

member2 = BoardMember.new(:board_id => board1.id,:user_id => user4.id,:permission => 1)
member2.save


#member of board2
member3 = BoardMember.new(:board_id => board2.id,:user_id => user3.id,:permission => 1)
member3.save


member4 = BoardMember.new(:board_id => board2.id,:user_id => user4.id,:permission => 1)
member4.save


#flows of board1
b1flow1 = Flow.new(:max_day => 5,:max_task => 5,:name => 'toDo',:order => 1,:board_id => board1.id)
b1flow1.save

b1flow2 = Flow.new(:max_day => 5,:max_task => 5,:name => 'Doing',:order => 2,:board_id => board1.id)
b1flow2.save

b1flow3 = Flow.new(:max_day => 5,:max_task => 5,:name => 'Done',:order => 3,:board_id => board1.id)
b1flow3.save

#subflow of b1flow1
b1f1sf = Flow.new(:max_day => 5,:max_task => 5,:name => 's',:order => 1,:board_id => board1.id,:flow_id =>b1flow1.id)
b1f1sf.save

#---------------------

#flows of board2
b2flow1 = Flow.new(:max_day => 5,:max_task => 5,:name => 'toDo',:order => 1,:board_id => board2.id)
b2flow1.save


b2flow2 = Flow.new(:max_day => 5,:max_task => 5,:name => 'Doing',:order => 2,:board_id => board2.id)
b2flow2.save

b2flow3 = Flow.new(:max_day => 5,:max_task => 5,:name => 'Done',:order => 3,:board_id => board2.id)
b2flow3.save

#subflow of b2flow1
b2f1sf = Flow.new(:max_day => 5,:max_task => 5,:name => 's',:order => 1,:board_id => board2.id,:flow_id =>b2flow1.id)
b2f1sf.save

#----------------------

#task of board1
b1task1 = Task.new(:state => 'normal',:name => 'task1',:description =>'task1_task1_task1_task1',:flow_id => b1f1sf.id,:order =>1,:type_id =>b1type1.id)
b1task1.save

b1task2 = Task.new(:state => 'normal',:name => 'task2',:description =>'task2_task2_task2_task2',:flow_id => b1f1sf.id,:order =>2,:type_id =>b1type1.id)
b1task2.save

b1task3 = Task.new(:state => 'normal',:name => 'task3',:description =>'task3_task3_task3_task3',:flow_id => b1f1sf.id,:order =>3,:type_id =>b1type1.id)
b1task3.save

b1task4 = Task.new(:state => 'normal',:name => 'task4',:description =>'task4_task4_task4_task4',:flow_id => b1f1sf.id,:order =>4,:type_id =>b1type1.id)
b1task4.save

b1task5 = Task.new(:state => 'normal',:name => 'task5',:description =>'task5_task5_task5_task5',:flow_id => b1f1sf.id,:order =>5,:type_id =>b1type1.id)
b1task5.save

#-----------------------

#task of board2
b2task1 = Task.new(:state => 'normal',:name => 'task1',:description =>'task1_task1_task1_task1',:flow_id => b2f1sf.id,:order =>1,:type_id =>b2type1.id)
b2task1.save

b2task2 = Task.new(:state => 'normal',:name => 'task2',:description =>'task2_task2_task2_task2',:flow_id => b2f1sf.id,:order =>2,:type_id =>b2type1.id)
b2task2.save

b2task3 = Task.new(:state => 'normal',:name => 'task3',:description =>'task3_task3_task3_task3',:flow_id => b2f1sf.id,:order =>3,:type_id =>b2type1.id)
b2task3.save

b2task4 = Task.new(:state => 'normal',:name => 'task4',:description =>'task4_task4_task4_task4',:flow_id => b2f1sf.id,:order =>4,:type_id =>b2type1.id)
b2task4.save

b2task5 = Task.new(:state => 'normal',:name => 'task5',:description =>'task5_task5_task5_task5',:flow_id => b2f1sf.id,:order =>5,:type_id =>b2type1.id)
b2task5.save

