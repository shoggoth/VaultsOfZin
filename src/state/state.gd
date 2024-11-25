class_name State extends Node

signal state_entered(state: State)
signal state_exited(state: State)

var sm: StateMachine = null
var valid_transitions = null		# null => any || [] => none || check array content

func change_state(state_name: String, params := {}):
	# In case state change is called from somewhere like the entry, defer it
	(func(): sm.enter_state_named(state_name, params)).call_deferred()

func enter_from(_from: State, _params: Dictionary) -> bool:
	state_entered.emit(self)
	return true

func exit_to(_to: State) -> bool:
	state_exited.emit(self)
	return true
