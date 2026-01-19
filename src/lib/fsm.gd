class_name FSMNode extends Node

# NOTE: Could possibly bind self onto the enter, update and exit calls if needed
# Might that result in a circular reference?

class FSM:
	class State:
		var name: String
		var _enter_func: Callable
		var _tick_func: Callable
		var _exit_func: Callable

		func _init(n: String, e: Callable = Callable(), t: Callable = Callable(), x: Callable = Callable()) -> void:
			name = n
			_enter_func = e
			_tick_func = t
			_exit_func = x
		
		func enter(from: State) -> void: if _enter_func.is_valid(): _enter_func.call(from)
		func update(delta: float) -> void: if _tick_func.is_valid(): _tick_func.call(delta)
		func exit(to: State) -> void: if _exit_func.is_valid(): _exit_func.call(to)

		func is_valid_next_state(next_state: State) -> bool: return next_state != self

	signal state_transition(from: State, to: State)

	var states: Dictionary[String, State]
	var state: State

	func _init(initial_states: Array[State] = []) -> void:
		for s in initial_states: add_state(s)

	func add_state(s: State) -> void: states[s.name] = s

	func enter_state(name: String = "") -> bool:
		var new_state: State = states[name] as State
		if !new_state: return false
		
		if state:
			if state.is_valid_next_state(new_state):
				state.exit(new_state)
			else: return false
		
		var old_state = state
		state = new_state
		new_state.enter(old_state)
		state_transition.emit(old_state, new_state)
		return true

	func update(delta: float) -> void: if state: state.update(delta)
