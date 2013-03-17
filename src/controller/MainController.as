package controller {
    import flash.geom.Point;
    import helpers.navigation.InterfaceType;
    import helpers.navigation.NavigatorController;
    import helpers.resources.ExternalResource;
    import helpers.resources.ResourceManager;
    import helpers.resources.ResourceType;
    import models.HiddenObject;
    import models.Level;
    import models.MainModel;

    public class MainController {

        private static const CONFIG:String = 'configXML';

        private var resourceManager:ResourceManager = ResourceManager.instance;
        private var navigator:NavigatorController = NavigatorController.instance;
        [Bindable]
        public var mainModel:MainModel = new MainModel();

        public function MainController(configUrl:String) {
            init(configUrl);
        }

        private function init(configUrl:String):void {
            resourceManager.load(new ExternalResource(CONFIG, configUrl, ResourceType.XML), parseXML);
        }

        private function parseXML():void {
            var xml:XML = resourceManager.getXmlById(CONFIG);
            var rooms:XMLList = xml.children();
            var i:int = 0;
            var levels:Vector.<Level> = new <Level>[];
            for each (var room:XML in rooms) {
                i++;
                var hiddenObjectXML:XMLList = room.children()
                var hiddenObjects:Vector.<HiddenObject> = new <HiddenObject>[];
                for each (var hiddenObjectXml:XML in hiddenObjectXML) {
                    var positions:Vector.<Point> = new <Point>[];
                    var positionsXML:XMLList = hiddenObjectXml.children();
                    for each (var positionXML:Object in positionsXML) {
                        positions.push(new Point(positionXML.@x, positionXML.@y));
                    }

                    hiddenObjects.push(new HiddenObject(hiddenObjectXml.@name, hiddenObjectXml.@src, positions));
                }

                levels.push(new Level('room' + i, room.@background, hiddenObjects));
            }

            mainModel.levels = levels;

            start();
        }

        public function start():void {
            mainModel.currentLevel = 0;
            navigator.show(InterfaceType.START, this);
        }

        public function play():void {
            var level:Level = getCurrentLevel();
            mainModel.moves = 0;
            mainModel.objectsToFind = level.objectsToFind;
            resourceManager.multiload(level.externalResources, onPreloadComplete);
        }

        private function onPreloadComplete():void {
            navigator.show(InterfaceType.SEEK_AND_FIND, this);
        }

        public function showScore():void {
            navigator.show(InterfaceType.SCORE, this);
        }

        public function getCurrentLevel():Level {
            return mainModel.currentLevel < mainModel.levels.length ? mainModel.levels[mainModel.currentLevel] : null;
        }

        public function incrementCounter(right:Boolean = false):void {
            mainModel.moves++;
            if(right && --mainModel.objectsToFind == 0) {
                showScore();
            }
        }

        public function nextLevel():void {
            if (!mainModel.isLastLevel) {
                mainModel.currentLevel++;
                play();
            } else {
                start();
            }
        }
    }
}
