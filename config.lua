--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SCRIPT BY REDYY#0449
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Config = {}

--- Options ---
Config.MoneyPerDelivery = 500 -- Money per Delivery
Config.DeliveryFinalMoney = 1000 -- Final Money
Config.ActivateDamage = true -- if true will depend on the life of the truck and will be deaccountanted from the Final Money.
Config.DeleteTruckWhenFinish = false -- Will truck be deleted when finish the job?

Config.AddDeliveryTruck = true -- Will the player have to delivery the truck when finish the job?
Config.DeliveryTruckNotification = 'Bring the truck back to the marker.'
Config.CoordDeliveryTruck = vector3(-65.64, -2500.52, 6.00)
Config.MarkerDeliveryTruck = '[ ~g~E ~w~] Return truck'
Config.VehicleDelivered = 'You have completed your tour, good job!'

Config.SpawnPointTrucker = { x = -102.83, y = -2529.71, z = 6.0 } -- Where Trucker will Spawn?
Config.TeleportPlayerToTruck = true -- Teleport Player to truck when spawn?
----

--- Messages ---
Config.ReceiveMoney = 'You have receive ' .. Config.MoneyPerDelivery .. '$ for delivery.'
Config.ReceiveFinalMoney = 'You won ' .. Config.DeliveryFinalMoney .. '$ for final delivery.'
Config.ALittleBroken = 'Looks like the truck is a little messed up, you will won less.'
Config.Broken = 'Looks like the truck barely are not working! You are going to have to pay for that.'
Config.NeedDeliveryFirst = '~r~You need to delivery the other location first.'
---

--- Progress Bar ---
Config.Duration = 5000 -- In MS
Config.Label = 'Deliverying'
Config.DisableMouse = false
----

Config.Menus = {
    ['start'] = {
        name = 'Trucker',
        label = 'Start a tour'
    },
    ['trucks'] = {
        name = 'Choose a truck',
        options = {"phantom","phantom3"}
    },
    ['trailers'] = {
        name = 'Choose a route',
        options = {
            ['trailers2'] = { -- Name of trailer model, can add/remove more trailers.
                name = 'Trailers2',
                route = 'route1' -- can change to route1/2/3/4.
            },
            ['trailers4'] = {
                name = 'trailer4',
                route = 'route2' 
            },
            ['trailers3'] = {
                name = 'Trailer 3',
                route = 'route3' 
            },
            ['tanker2'] = {
                name = 'Tanker 2',
                route = 'route4' 
            }
        }
    },
    ['confirm'] = {
        name = 'Start the Tour?',
        yes = {label = 'Yes'},
        no = {label = 'No'}
    }
}

Config.Markers = {
    ['start_job'] = {
        name = 'Start',
        cancel = 'Cancel',
        event = 'ry_truckerjob:start_job',
        coord = vector3(-59.63,-2523.16,6.15),
        marker = {
            type = 2, -- can found in https://docs.fivem.net/docs/game-references/markers/
            size  = {x = 0.5, y = 0.5, z = 0.5},
            color = {r = 204, g = 204, b = 0}
        },
        blip = {
            Name = 'Trucker',
            Sprite = 67,
            Scale = 0.8,
            Colour = 5
        }
    },
}

Config.Routes = {
    -- Route1
    ['route1'] = {
        ['locations'] = {
            [1] = {
                active = false, -- don't change
                delivered = false, -- don't change
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.31,-3304.8,5.99),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [2] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.49,-3205.1,5.63),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            }, 
            [3] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(190.12,-3049.49,5.81),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [4] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:last_delivery', 
                coord = vector3(228.02,-2904.35,5.96),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            } 
        }
    },
    ['route2'] = {
        ['locations'] = {
            [1] = {
                active = false, -- don't change
                delivered = false, -- don't change
                event = 'ry_truckerjob:delivery', 
                coord = vector3(646.33,-2800.74,6.0),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [2] = {
                active = false, -- don't change
                delivered = false, -- don't change
                event = 'ry_truckerjob:delivery', 
                coord = vector3(188.73,-3203.74,5.79),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [3] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(2942.02,2800.73,40.99),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [4] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:last_delivery', 
                coord = vector3(-494.19,-940.17,23.96),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            } 
        }
    },
    ['route3'] = {
        ['locations'] = {
            [1] = {
                active = false, -- don't change
                delivered = false, -- don't change
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.31,-3304.8,6.5),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [2] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.49,-3205.1,5.63),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            }, 
            [3] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(190.12,-3049.49,5.81),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [4] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:last_delivery', 
                coord = vector3(228.02,-2904.35,5.96),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            } 
        }
    },
    ['route4'] = {
        ['locations'] = {
            [1] = {
                active = false, -- don't change
                delivered = false, -- don't change
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.31,-3304.8,5.99),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [2] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(178.49,-3205.1,5.63),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            }, 
            [3] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:delivery', 
                coord = vector3(190.12,-3049.49,5.81),
                marker = {
                    type = 21,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            },
            [4] = {
                active = false,
                delivered = false,
                event = 'ry_truckerjob:last_delivery', 
                coord = vector3(228.02,-2904.35,5.96),
                marker = {
                    type = 2,
                    text = "[ ~g~E ~w~] ~w~To Delivery",
                    text_delivered = "~y~Delivered, Go To Next Point",
                    size  = {x = 0.5, y = 0.5, z = 0.5},
                    color = {r = 204, g = 204, b = 0}
                },
            } 
        }
    },

    -- Don't add more
}