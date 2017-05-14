#!/bin/bash
# utilitymenu.sh - A sample shell script to display menus on screen
# Store menu options selected by the user
#INPUT=/tmp/menu.sh.$$
INPUT=menu.sh.$$

# Storage file for displaying cal and date command output
#OUTPUT=/tmp/output.sh.$$
OUTPUT=output.sh.$$

# get text editor or fall back to vi_editor
vi_editor=${EDITOR-vi}

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function display_output(){
	local h=${1-10}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title 
	dialog --backtitle "Linux Shell Smarthouse Controll" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}

show_Ligths() {
  while true
  do
    dialog \
    --title "Ligths" \
    --menu "Select a floor:" 12 60 5 \
    1 "Floor 1" \
    2 "Floor 2" \
	3 "Exit" 2>"${INPUT}"

menuitem=$(<"${INPUT}")
case $menuitem in
      1) show_floor2;;
      2) show_floor2;;
      3) return;;
    esac
  done
}

show_floor1() {
  while true
  do
    dialog \
    --title "Ligths floor 1" \
    --menu "Select a ligth:" 12 60 5 \
    1 "Trappelys" \
    2 "Ganglys" \
    3 "LED list" \
    4 "Connie Taklys" \
    5 "Connie Vinduslys" \
    6 "Connie sengelys" \
	7 "Exit" 2>"${INPUT}"

menuitem=$(<"${INPUT}")
case $menuitem in
      1) trapp_cards;;
      2) show_floor2;;
      3) select_dma;;
      4) view_summary;;
      5) return;;
    esac
  done
}

show_floor2() {
  while true
  do
    dialog \
    --title "Ligths floor 2" \
    --menu "Select a ligth:" 12 60 10 \
    1 "Trappelys" \
    2 "Ganglys" \
    3 "LED list" \
    4 "Connie Taklys" \
    5 "Connie Vinduslys" \
    6 "Connie sengelys" \
    7 "Walter Taklys" \
    8 "Walter Vinduslys" \
    9 "Walter innhukslys" \
	10 "Exit" 2>"${INPUT}"

menuitem=$(<"${INPUT}")
case $menuitem in
      1) select_Ligth_trapp;;
      2) select_Ligth_gang2;;
      3) select_Ligth_LED_gang2;;
      4) select_Ligth_Connie_taklys;;
      5) select_Ligth_Connie_sengelys;;
      6) select_Ligth_Connie_vinduslys;;
      7) select_Ligth_Walter_taklys;;
      8) select_Ligth_Walter_vinduslys;;
      9) select_Ligth_Walter_innhukslys;;
     10) return;;
    esac
  done
}

function select_Ligth_trapp(){
	knxtool on ip:localhost 1/1/23 >$OUTPUT
	display_output 13 25 "Trapp on"
}

function select_Ligth_gang2(){
	knxtool on ip:localhost 1/1/47 >$OUTPUT
	display_output 13 25 "Gang 2 etg on"
}

function select_Ligth_LED_gang2(){
	knxtool on ip:localhost 1/1/48 >$OUTPUT
	display_output 13 25 "Gang 2 etg LED on"
}

function select_Ligth_Connie_taklys(){
	knxtool on ip:localhost 1/1/31 >$OUTPUT
	display_output 13 25 "Connie taklys on"
}

function select_Ligth_Connie_sengelys(){
	knxtool on ip:localhost 1/1/32 >$OUTPUT
	display_output 13 25 "Connie taklys on"
}

function select_Ligth_Connie_vinduslys(){
	knxtool on ip:localhost 1/1/33 >$OUTPUT
	display_output 13 25 "Connie vinduslys on"
}

function select_Ligth_Walter_taklys(){
	knxtool on ip:localhost 1/1/39 >$OUTPUT
	display_output 13 25 "Walter taklys on"
}

function select_Ligth_Walter_vinduslys(){
	knxtool on ip:localhost 1/1/41 >$OUTPUT
	display_output 13 25 "Walter vinduslys on"
}


function select_Ligth_Walter_innhukslys(){
	knxtool on ip:localhost 1/1/40 >$OUTPUT
	display_output 13 25 "Walter innhukslys on"
}

show_knx() {
  while true
  do
    dialog \
    --title "Edit Configuration" \
    --menu "Select a function:" 12 60 5 \
    1 "Trappelys" \
    2 "Ganglys" \
    3 "LED list" \
    4 "Connie Taklys" \
    5 "Connie Vinduslys" \
    6 "Connie sengelys" \
    7 "Walter Taklys" \
    8 "Walter Vinduslys" \
    9 "Walter innhukslys" \
	10 "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")
case $menuitem in
      1) select_cards;;
      2) select_irq;;
      3) select_dma;;
      4) view_summary;;
      5) return;;
    esac
  done
}
#
# Purpose - display current system date & time
#
function show_date(){
	echo "Today is $(date) @ $(hostname -f)." >$OUTPUT
    display_output 6 60 "Date and Time"
}

#
# Purpose - display a calendar
#
function show_calendar(){
	cal >$OUTPUT
	display_output 13 25 "Calendar"
}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear --backtitle "Linux Shell Smarthouse Controll" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the \n\
		nummber in [] is a hot key.
		Choose the TASK" 15 50 10 \
		L "[L]igths" \
		2 "[2]Rom temperature" \
		3 "[3]Energy" \
		4 "[4]Sensors" \
		5 "Show knx" \
		Date/time "Displays date and time" \
		Calendar "Displays a calendar" \
		Editor "Start a text editor" \
		Exit "Exit to the shell" 2>"${INPUT}"


menuitem=$(<"${INPUT}")

# Main menu
# make decsion 
case $menuitem in
	L) show_Ligths;;
	2) select_irq;;
	3) select_dma;;
	4) view_summary;;
	5) show_knx;;
	Date/time) show_date;;
	Calendar) show_calendar;;
	Editor) $vi_editor;;
	Exit) echo "Bye"; break;;
	esac
done


# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT

