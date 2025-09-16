extends Resource

class_name NpcData

@export var name : String
@export var username : String
@export var password : String
@export_enum(
	"al@company.com", 
	"brian@company.com", 
	"gigi@company.com",
	"joe@company.com", 
	"john@company.com", 
	"koro@company.com",
	"liz@company.com", 
	"mike@company.com", 
	"mococo@company.com",
	"myrione@company.com", 
	"robert@company.com", 
	"sai@company.com",
	"shion@company.com", 
	"walter@company.com", 
	"wisadel@company.com"
) var email: String
@export var desktop : PackedScene
@export var text : String = ""

@export var pirating : bool = false
