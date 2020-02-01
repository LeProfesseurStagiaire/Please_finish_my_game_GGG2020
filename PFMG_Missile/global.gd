extends Node

var best_score = 0
onready var wave_unlocked = 45
var wave_selected = 1
onready var max_wave = wave.size()
var caract_list = ["speed","scale_ratio","rotation_speed","next_spawn_time"]
var game_runing = false
#used to select the last level selected if you die without unlock new wave
var wave_unlocked_this_turn = false
var wave_win_this_turn = false

var wave = {

"wave_1" : {
        "Etype" : [1], 
        "Ecarac" : {
                1:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(1.2,2.2)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.0, 0.858, 0.827),"scale" : Vector2(0.91,0.91)
        }
},

"wave_2" : {
        "Etype" : [2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(1.2,2.2)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.011, 0.784, 0.815),"scale" : Vector2(0.86,0.86)
        }
},

"wave_3" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"next_spawn_time" : Vector2(1.2,1.2)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.023, 0.698, 0.804),"scale" : Vector2(0.81,0.81)
        }
},

"wave_4" : {
        "Etype" : [4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(1.2,2.2)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.039, 0.620, 0.788),"scale" : Vector2(0.76,0.76)
        }
},

"wave_5" : {
        "Etype" : [1,4], 
        "Ecarac" : {
                1:{"speed": Vector2(1.5,2.4),"next_spawn_time" : Vector2(0.4,0.7)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.051, 0.537, 0.776),"scale" : Vector2(0.71,0.71)
        }
},
"wave_6" : {
        "Etype" : [1,2], 
        "Ecarac" : {
                2:{"speed": Vector2(0.6,2),"scale_ratio":Vector2(0.4,1.1)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.067, 0.451, 0.765),"scale" : Vector2(0.66,0.66)
        }
},
"wave_7" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"speed": Vector2(3,4.5),"next_spawn_time" : Vector2(0.4,0.7)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.078, 0.369, 0.753),"scale" : Vector2(0.61,0.61)
        }
},
"wave_8" : {
        "Etype" : [3,4], 
        "Ecarac" : {
                3:{"speed": Vector2(3,4)},
                4:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(0.5,0.9),"scale_ratio" : Vector2(0.15,0.3)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.090, 0.290, 0.737),"scale" : Vector2(0.56,0.56)
        }
},
"wave_9" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(1.5,2)},
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.106, 0.208, 0.729),"scale" : Vector2(0.51,0.51)
        }
},
"wave_10" : {
        "Etype" : [1,2,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,2),"next_spawn_time" : Vector2(0.15,0.3)},
                3:{"speed": Vector2(2,4),"next_spawn_time" : Vector2(0.15,0.3)}
        },
        "param" : {
                "goal_time" : int(8),"color" : Color(0.118, 0.125, 0.714),"scale" : Vector2(0.46,0.46)
        }
},

"wave_11" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1.5,2),"next_spawn_time" : Vector2(0.15,0.3),"rotation_speed":Vector2(0.2,0.8)},
                3:{"speed": Vector2(3,6),"next_spawn_time" : Vector2(0.15,0.3)},
                1:{"next_spawn_time" : Vector2(0.8,1.5),"scale_ratio":Vector2(0.15,0.22)}
        },
        "param" : {
                "goal_time" : int(20),"color" : Color(0.129, 0.051, 0.702)
        }
},

"wave_12" : {
        "Etype" : [1], 
        "Ecarac" : {
                1:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.451, 1.0, 0.427),"scale" : Vector2(0.9,0.9)
        }
},

"wave_13" : {
        "Etype" : [2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.412, 0.937, 0.384),"scale" : Vector2(0.85,0.85)
        }
},

"wave_14" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"next_spawn_time" : Vector2(1,1)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.369, 0.867, 0.345),"scale" : Vector2(0.8,0.8)
        }
},

"wave_15" : {
        "Etype" : [4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.325, 0.8, 0.302),"scale" : Vector2(0.75,0.75)
        }
},

"wave_16" : {
        "Etype" : [1,4], 
        "Ecarac" : {
                1:{"speed": Vector2(2,3),"next_spawn_time" : Vector2(0.3,0.6)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.282, 0.733, 0.259),"scale" : Vector2(0.7,0.7)
        }
},
"wave_17" : {
        "Etype" : [1,2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"scale_ratio":Vector2(0.5,1.3)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.243, 0.671, 0.220),"scale" : Vector2(0.65,0.65)
        }
},
"wave_18" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"speed": Vector2(4,6),"next_spawn_time" : Vector2(0.3,0.5)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.196, 0.6, 0.180),"scale" : Vector2(0.6,0.6)
        }
},
"wave_19" : {
        "Etype" : [3,4], 
        "Ecarac" : {
                3:{"speed": Vector2(4,5)},
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.4,0.7),"scale_ratio" : Vector2(0.2,0.35)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.157, 0.537, 0.137),"scale" : Vector2(0.55,0.55)
        }
},
"wave_20" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.110, 0.467, 0.094),"scale" : Vector2(0.5,0.5)
        }
},
"wave_21" : {
        "Etype" : [1,2,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.1,0.2)},
                3:{"speed": Vector2(3,5),"next_spawn_time" : Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.067, 0.4, 0.051),"scale" : Vector2(0.45,0.45)
        }
},

"wave_22" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(2,2.5),"next_spawn_time" : Vector2(0.1,0.2),"rotation_speed":Vector2(0.5,1)},
                3:{"speed": Vector2(5,8),"next_spawn_time" : Vector2(0.1,0.2)},
                1:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(30),"color" : Color(0.335938, 0, 0)
        }
},

"wave_23" : {
        "Etype" : [1], 
        "Ecarac" : {
                1:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.047059, 0.321569, 0.329412),"scale" : Vector2(0.9,0.9)
        }
},

"wave_24" : {
        "Etype" : [2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.157059, 0.321569, 0.329412),"scale" : Vector2(0.85,0.85)
        }
},

"wave_25" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"next_spawn_time" : Vector2(1,1)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.267059, 0.321569, 0.329412),"scale" : Vector2(0.8,0.8)
        }
},

"wave_26" : {
        "Etype" : [4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.377059, 0.321569, 0.329412),"scale" : Vector2(0.75,0.75)
        }
},

"wave_27" : {
        "Etype" : [1,4], 
        "Ecarac" : {
                1:{"speed": Vector2(2,3),"next_spawn_time" : Vector2(0.3,0.6)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.477059, 0.321569, 0.329412),"scale" : Vector2(0.7,0.7)
        }
},
"wave_28" : {
        "Etype" : [1,2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"scale_ratio":Vector2(0.5,1.3)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.577059, 0.321569, 0.329412),"scale" : Vector2(0.65,0.65)
        }
},
"wave_29" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"speed": Vector2(4,6),"next_spawn_time" : Vector2(0.3,0.5)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.677059, 0.321569, 0.329412),"scale" : Vector2(0.6,0.6)
        }
},
"wave_30" : {
        "Etype" : [3,4], 
        "Ecarac" : {
                3:{"speed": Vector2(4,5)},
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.4,0.7),"scale_ratio" : Vector2(0.2,0.35)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.777059, 0.321569, 0.329412),"scale" : Vector2(0.55,0.55)
        }
},
"wave_31" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.87059, 0.321569, 0.329412),"scale" : Vector2(0.5,0.5)
        }
},
"wave_32" : {
        "Etype" : [1,2,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.1,0.2)},
                3:{"speed": Vector2(3,5),"next_spawn_time" : Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.977059, 0.321569, 0.329412),"scale" : Vector2(0.45,0.45)
        }
},

"wave_33" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(2,2.5),"next_spawn_time" : Vector2(0.1,0.2),"rotation_speed":Vector2(0.5,1)},
                3:{"speed": Vector2(5,8),"next_spawn_time" : Vector2(0.1,0.2)},
                1:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(30),"color" : Color(0.335938, 0, 0)
        }
},

"wave_34" : {
        "Etype" : [1], 
        "Ecarac" : {
                1:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.047059, 0.321569, 0.329412),"scale" : Vector2(0.9,0.9)
        }
},

"wave_35" : {
        "Etype" : [2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.157059, 0.321569, 0.329412),"scale" : Vector2(0.85,0.85)
        }
},

"wave_36" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"next_spawn_time" : Vector2(1,1)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.267059, 0.321569, 0.329412),"scale" : Vector2(0.8,0.8)
        }
},

"wave_37" : {
        "Etype" : [4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.377059, 0.321569, 0.329412),"scale" : Vector2(0.75,0.75)
        }
},

"wave_38" : {
        "Etype" : [1,4], 
        "Ecarac" : {
                1:{"speed": Vector2(2,3),"next_spawn_time" : Vector2(0.3,0.6)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.477059, 0.321569, 0.329412),"scale" : Vector2(0.7,0.7)
        }
},
"wave_39" : {
        "Etype" : [1,2], 
        "Ecarac" : {
                2:{"speed": Vector2(1,3),"scale_ratio":Vector2(0.5,1.3)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.577059, 0.321569, 0.329412),"scale" : Vector2(0.65,0.65)
        }
},
"wave_40" : {
        "Etype" : [3], 
        "Ecarac" : {
                3:{"speed": Vector2(4,6),"next_spawn_time" : Vector2(0.3,0.5)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.677059, 0.321569, 0.329412),"scale" : Vector2(0.6,0.6)
        }
},
"wave_41" : {
        "Etype" : [3,4], 
        "Ecarac" : {
                3:{"speed": Vector2(4,5)},
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.4,0.7),"scale_ratio" : Vector2(0.2,0.35)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.777059, 0.321569, 0.329412),"scale" : Vector2(0.55,0.55)
        }
},
"wave_42" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.87059, 0.321569, 0.329412),"scale" : Vector2(0.5,0.5)
        }
},
"wave_43" : {
        "Etype" : [1,2,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.1,0.2)},
                3:{"speed": Vector2(3,5),"next_spawn_time" : Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(10),"color" : Color(0.977059, 0.321569, 0.329412),"scale" : Vector2(0.45,0.45)
        }
},

"wave_44" : {
        "Etype" : [1,3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(2,2.5),"next_spawn_time" : Vector2(0.1,0.2),"rotation_speed":Vector2(0.5,1)},
                3:{"speed": Vector2(5,8),"next_spawn_time" : Vector2(0.1,0.2)},
                1:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(30),"color" : Color(0.335938, 0, 0)
        }
},

"wave_45" : {
        "Etype" : [1,2, 3,4], 
        "Ecarac" : {
                4:{"speed": Vector2(2,2.5),"next_spawn_time" : Vector2(0.1,0.2),"rotation_speed":Vector2(0.5,1)},
                3:{"speed": Vector2(5,8),"next_spawn_time" : Vector2(0.1,0.2)},
                2:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)},                
                1:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)}
        },
        "param" : {
                "goal_time" : int(60),"color" : Color(0, 0, 0)
        }
},

}