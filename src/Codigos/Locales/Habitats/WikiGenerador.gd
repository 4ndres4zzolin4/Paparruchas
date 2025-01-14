extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Objetos/VentanaWiki.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")
onready var wikiVirus = preload("res://Escenas/Objetos/VirusWiki.tscn")
onready var screenWidth = get_viewport().size.x
onready var playzoneStart = screenWidth * Constants.playableArea


func _ready():
	Manager.connect("s_afueraPantalla",self, "mmostarX")
	Manager.connect("s_virusTimer", self, "ClickVirus")

func _process(delta):
	pass



func spawnWiki():

	var wiki = wikiPaquete.instance()
	var wikiH = wiki.get_node("Wiki").texture.get_height()
	var wikiW = wiki.get_node("Wiki").texture.get_width()
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 100)
	add_child(wiki)

func spawnWikiVirus():

	var wikiVi = wikiVirus.instance()
	var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
	var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
	wikiVi.position = Vector2(rand_range(playzoneStart,screenWidth -(wikiWV/2)) , -(wikiHV/2) - 150)
	add_child(wikiVi)

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWiki()

func _on_TimerVirus_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWikiVirus()

func ClickVirus():
	$TimerVirus.wait_time -= 0.3

func _on_TimerFinal_timeout():
	Manager.estadoJuegoActual = Manager.EstadoJuego.EN_JUEGO

func mmostarX(x):
	var newWikiX = wikiX.instance()
	newWikiX.position = Vector2(x, get_viewport().size.y - 100)
	add_child(newWikiX);

