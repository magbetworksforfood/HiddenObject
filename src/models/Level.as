package models {
    import helpers.resources.ExternalResource;

    public class Level extends GameActor {

        public var hiddenObjects:Vector.<HiddenObject>;
        public var externalResources:Vector.<ExternalResource> = new <ExternalResource>[];

        public function Level(name:String, imageURL:String, hiddenObjects:Vector.<HiddenObject>) {
            super(name, imageURL);
            this.hiddenObjects = hiddenObjects;

            externalResources.push(new ExternalResource(name, imageURL));

            for each (var hiddenObject:HiddenObject in hiddenObjects) {
                externalResources.push(new ExternalResource(hiddenObject.name, hiddenObject.imageUrl));
            }
        }

        public function get objectsToFind():uint {
            return hiddenObjects ? hiddenObjects.length : 0;
        }
    }
}
