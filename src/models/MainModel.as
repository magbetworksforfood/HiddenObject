package models {
    public class MainModel {

        //tries
        [Bindable]
        public var moves:uint;
        public var objectsToFind:uint;

        private var _currentLevel:int;
        [Bindable]
        public var isLastLevel:Boolean;

        public var levels:Vector.<Level> = new <Level>[];

        public function MainModel() {
        }

        public function get currentLevel():int {
            return _currentLevel;
        }

        public function set currentLevel(value:int):void {
            if (_currentLevel != value) {
                _currentLevel = value;

                isLastLevel = _currentLevel == levels.length - 1;
            }
        }
    }
}
