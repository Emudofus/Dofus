package ui.behavior
{
    import ui.AbstractStorageUi;

    public interface IStorageBehavior 
    {

        function dropValidator(_arg_1:Object, _arg_2:Object, _arg_3:Object):Boolean;
        function processDrop(_arg_1:Object, _arg_2:Object, _arg_3:Object):void;
        function attach(_arg_1:AbstractStorageUi):void;
        function detach():void;
        function filterStatus(_arg_1:Boolean):void;
        function onRelease(_arg_1:Object):void;
        function onSelectItem(_arg_1:Object, _arg_2:uint, _arg_3:Boolean):void;
        function transfertAll():void;
        function transfertList():void;
        function transfertExisting():void;
        function onUnload():void;
        function getStorageUiName():String;
        function getName():String;
        function get replacable():Boolean;

    }
}//package ui.behavior

