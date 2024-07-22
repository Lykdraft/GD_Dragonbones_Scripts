#############################################################################################
### WARNING: This is tested with my own DragonBones Character exported by Drangonbones     ##
### with Export Type: DragonBones JSON, Data Version: 5.0, Image Type: Texture Atlas       ##
### This code somehow doesn't do anything with the 'Default Dragon' but DOES with the      ##
### default 'Uhbie' Character. Not sure why.                                               ##
### But when you run the code, you'll see in the Console the (0,0,0,1), a.k.a. COLOR.Black ##
### before and after the animation. So it works when properly exported DragonBones         ##
### Character with the appropiate export settings. Have a nice day! @Lykdraft              ##
#############################################################################################

extends DragonBones

@onready var db :DragonBones = $"."
@onready var dba :DragonBonesArmature = db.armature

var slot_colors: Dictionary = {}
var color


func _ready() -> void:
	
	print("current animation: " , dba.current_animation)
	print("get anmations: ", dba.get_animations())
		
	var legL = dba.get_slot("leg_l") as DragonBonesSlot
	legL.set_display_index(-1)  # left leg is gone.
	
	var body = dba.get_slot("body") as DragonBonesSlot
	body.set_display_color_multiplier(Color.BLACK) # making the body black BEFORE a new animation.
	
	var legR = dba.get_slot("leg_r") as DragonBonesSlot
	legR.set_display_color_multiplier(Color.BLACK)
	
	apply_slot_colors()  ### Applying the colors to the dictionary to save the state
	dba.play("walk", -1) ### new animation started
	reapply_slot_colors() ### Reapply the correct colors to the correct name AFTER the animation
	
	print("final slotcolors: :", slot_colors, " -- final val: ", slot_colors.values())
	
	############################################################################################
	### INFO: you could also put the reapply_slot_color function into an animation function   ##
	## which fires the dba.play_from_progress() at the end from that code.                    ##
	############################################################################################


func apply_slot_colors():	
	
	var slots = dba.get_slots()

	for slot_name in slots: ##### YAI, seems to work.
		color = dba.get_slot_display_color_multiplier(slot_name)
		slot_colors[slot_name] = color ### slot_colors defined as a dictionary above
		dba.set_slot_display_color_multiplier(slot_name, color)
	
	print("apply slot colors: ", slot_colors)


func reapply_slot_colors():

	for sname in slot_colors: ### slot_colors defined as a dictionary above
		print("sname: ", sname)
		print("slot color after reapply: ", slot_colors[sname])
		dba.set_slot_display_color_multiplier(sname, slot_colors[sname])
		
################################################################################
# INFO: This code is a little bit messy but works. Feel free to refactor it in #
# a cleaner, nicer way and maybe get rid of the print statements... ;)         #
################################################################################
