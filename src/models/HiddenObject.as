package models {
    import flash.geom.Point;

    public class HiddenObject extends GameActor {

        public var positions:Vector.<Point>;

        public function HiddenObject(name:String, imageURL:String, positions:Vector.<Point> ) {
            super(name, imageURL)
            this.positions = positions;
        }
    }
}
