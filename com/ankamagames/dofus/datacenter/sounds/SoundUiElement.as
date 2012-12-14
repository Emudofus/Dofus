package com.ankamagames.dofus.datacenter.sounds
{
    import com.ankamagames.jerakine.interfaces.*;

    public class SoundUiElement extends Object implements IDataCenter
    {
        public var id:uint;
        public var name:String;
        public var hookId:uint;
        public var file:String;
        public var volume:uint;
        public static var MODULE:String = "SoundUiElement";

        public function SoundUiElement()
        {
            return;
        }// end function

        public function get hook() : String
        {
            var _loc_1:* = SoundUiHook.getSoundUiHookById(this.id);
            return _loc_1 ? (_loc_1.name) : (null);
        }// end function

    }
}
