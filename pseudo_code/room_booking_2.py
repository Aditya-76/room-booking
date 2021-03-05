def request():
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
    return (start,end)



# result = time.localtime(1545925769)
# time_string = time.strftime("%m/%d/%Y, %H:%M:%S", named_tuple)



def printf():
    for room in rooms.keys():
        print(room, end = ":")
        no_entries = len(rooms[room])
        if no_entries != 0:
            print()
            for data in rooms[room]:
                sec1 = time.localtime(data[0])
                start = time.strftime("%d %B %Y, %H:%M", sec1)
                sec2 = time.localtime(data[1])
                end = time.strftime("%d %B %Y, %H:%M", sec2)
                print("From "+start+" to "+end)
            print()
        else:
            print(" Empty")
            print()



import time
# begin = 1613069289
rooms = {"Room 1": [],
		"Room 2": [],
		"Room 3": []}

no_requests = int(input("\nNo of requests?\n"))
print()
for _ in range(no_requests):
    a = request()
    start = a[0]
    end = a[1]

    flag_added = 0
    for room in rooms.keys():
        flag_room = -1
        for i in range(len(rooms[room])):
            if ((rooms[room][i][0]<start<rooms[room][i][1]) or (rooms[room][i][0]<end<rooms[room][i][1]) or (rooms[room][i][0]<start<end<rooms[room][i][1]) or (start<rooms[room][i][0]<rooms[room][i][1]<end) or (rooms[room][i][0]==start) or (end==rooms[room][i][1])):
                flag_room = i
                break
            else:
                continue

        if flag_room == -1:
            rooms[room] = rooms[room]+[[start,end]]
            flag_added = room
            break

    print("Output for User:")
    if flag_added != 0:
        print('"'+flag_added+' has been booked."\n')
    else:
        print('"Room cannot be booked."\n')

    printf()
    print()
    print()



