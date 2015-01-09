package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2components.ButtonContainer;
    import d2actions.ChangeCharacter;
    import d2actions.*;
    import d2hooks.*;

    public class HardcoreDeath 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var btn_close:ButtonContainer;
        public var btn_yes:ButtonContainer;


        public function main(args:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_yes:
                    this.sysApi.sendAction(new ChangeCharacter(this.sysApi.getCurrentServer().id));
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            return (true);
        }


    }
}//package ui

