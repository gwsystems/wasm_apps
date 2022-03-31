(module
	(global $counter (mut i32) (i32.const 0))

	(func (export "increment") (result i32)
		(global.set $counter (i32.add (global.get $counter) (i32.const 1)))
		(global.get $counter)
	)

	(func $init
		(global.set $counter (i32.const 42))
	)

	(start $init)
	
)
