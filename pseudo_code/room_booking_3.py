import time
import tkinter as tk

#Number of rooms is first entry.
#Index is the second entry.
def initialize():
    global room_quantity
    room_quantity = {"Table Tennis": [6, 1],
                     "Squash"     :  [3, 2],
                     "Basketball" :  [4, 3],
                     "Football"   :  [5, 4]}
    global rooms
    for i in room_quantity.values():
        room = {}
        for j in range(i[0]):
            key = "Room " + str(j+1)
            room[key] = []
        rooms.append(room)


def entry():
    r_type = input("What do you want to book ?\n")
    print()

    print("Format for entering time is......")
    print("d m y, hr:min")
    print("NOTE - Add ZEROS if needed!")
    print("NOTE - Enter time in 24hrs format!")
    print("NOTE - Write complete month name!")
    print("Sample Input: 01 February 2021, 00:00\n")


    start_ = input("Enter starting date and time.\n")
    print()
    end_ = input("Enter ending date and time.\n")
    print()
    t = time.strptime(start_, "%d %B %Y, %H:%M")
    start = time.mktime(t)
    t = time.strptime(end_, "%d %B %Y, %H:%M")
    end = time.mktime(t)
    ti = (start,end)
    return (r_type, ti)


def request(name,a):
    start = a[1][0]
    end = a[1][1]
    r_type = a[0]
    index = room_quantity[r_type][1] - 1
    category_room = rooms[index]

    flag_added = 0
    for room in category_room.keys():
        flag_room = -1
        for i in range(len(category_room[room])):
            if ((category_room[room][i][0] < start < category_room[room][i][1]) or (category_room[room][i][0] < end < category_room[room][i][1]) or (category_room[room][i][0] < start < end < category_room[room][i][1]) or (start < category_room[room][i][0] < category_room[room][i][1] < end) or (category_room[room][i][0] == start) or (end == category_room[room][i][1])):
                flag_room = i
                break
            else:
                continue

        if flag_room == -1:
            authorize(name, a, room)
            if(var):
                print('"Your '+r_type+' (Room '+str(index+1)+') has been booked."\n\n')
                category_room[room] = category_room[room]+[[start, end]]
                flag_added = room
                break
            else:
                print('"You were not authorized"\n\n')

    return flag_added


def authorize(name, a, room):
    global var
    def yes():
        global var
        var = 1
        root.destroy()

    def no():
        global var
        var = 0
        root.destroy()

    root = tk.Tk()
    root.winfo_toplevel().title("Authorise")
    root.geometry(f'{400}x{140}')

    sec1 = time.localtime(a[1][0])
    start = time.strftime("%d %B %Y, %H:%M", sec1)
    sec2 = time.localtime(a[1][1])
    end = time.strftime("%d %B %Y, %H:%M", sec2)
    st = name+"\n"+a[0]+" ("+room+")\nFrom: "+start+"\nTo: "+end+"\n\nApprove ?\n"
    mainLabel = tk.Label(root, text=st)
    mainLabel.pack()

    yesbt = tk.Button(root, text='Yes', command=yes)
    yesbt.pack(side='left', fill='x', expand=True)

    nobt = tk.Button(root, text='No', command=no)
    nobt.pack(side='right', fill='x', expand=True)
    root.mainloop()


def printf():
    for r_type in room_quantity.keys():
        print('****  '+r_type+'  ****')
        index = index = room_quantity[r_type][1] - 1
        for room in rooms[index].keys():
            print(room, end = ":")
            no_entries = len(rooms[index][room])
            if no_entries != 0:
                print()
                for data in rooms[index][room]:
                    sec1 = time.localtime(data[0])
                    start = time.strftime("%d %B %Y, %H:%M", sec1)
                    sec2 = time.localtime(data[1])
                    end = time.strftime("%d %B %Y, %H:%M", sec2)
                    print("From "+start+" to "+end)
                print()
            else:
                print(" Empty")
                print()
        print()





#Code starts from here.
room_quantity ={}
rooms = []
var = 0
initialize()

name = input("\nEnter your name:\n")
no_requests = int(input("\nNo of requests?\n"))
print()
for _ in range(no_requests):
    a = entry()
    r_type = a[0]
    print("\nOutput for User:")
    check = request(name,a)
    if(check == 0):
        print('"The room cannot be booked as all room are occupied."\n\n')
    printf()
    print()
    print()

# result = time.localtime(1545925769)
# time_string = time.strftime("%m/%d/%Y, %H:%M:%S", named_tuple)
# begin = 1613069289
