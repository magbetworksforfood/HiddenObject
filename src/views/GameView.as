package views {
    import controller.MainController;

    import helpers.navigation.AbstractView;

    public class GameView extends AbstractView {

        [Bindable]
        protected var controller:MainController;


        override public function set data(value:Object):void {
            if (_data != value) {
                super.data = value;

                controller = MainController(value);
            }
        }

        public function GameView() {
        }
    }
}
