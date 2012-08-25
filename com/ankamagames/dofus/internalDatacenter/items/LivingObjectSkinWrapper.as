package com.ankamagames.dofus.internalDatacenter.items
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.*;

    public class LivingObjectSkinWrapper extends Object implements ISlotData
    {
        private var _id:int;
        private var _category:int;
        private var _mood:int;
        private var _skin:int;
        private var _uri:Uri;
        private var _pngMode:Boolean;

        public function LivingObjectSkinWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this.getIconUri(true);
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this.getIconUri(false);
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get mood() : int
        {
            return this._mood;
        }// end function

        public function get skin() : int
        {
            return this._skin;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get errorIconUri() : Uri
        {
            return null;
        }// end function

        public function getIconUri(param1:Boolean = true) : Uri
        {
            var _loc_3:int = 0;
            var _loc_2:Boolean = false;
            if (this._uri)
            {
                if (param1 != this._pngMode)
                {
                    _loc_2 = true;
                }
            }
            else
            {
                _loc_2 = true;
            }
            if (_loc_2)
            {
                _loc_3 = LivingObjectSkinJntMood.getLivingObjectSkin(this._id, this._mood, this._skin);
                if (param1)
                {
                    this._pngMode = true;
                    this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(_loc_3).concat(".png"));
                }
                else
                {
                    this._pngMode = false;
                    this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(_loc_3).concat(".swf"));
                }
            }
            return this._uri;
        }// end function

        public function get info1() : String
        {
            return null;
        }// end function

        public function get timer() : int
        {
            return 0;
        }// end function

        public function get active() : Boolean
        {
            return true;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public static function create(param1:int, param2:int, param3:int) : LivingObjectSkinWrapper
        {
            var _loc_4:* = new LivingObjectSkinWrapper;
            var _loc_5:* = Item.getItemById(param1);
            _loc_4._id = param1;
            _loc_4._category = _loc_5.category;
            _loc_4._mood = param2;
            _loc_4._skin = param3;
            return _loc_4;
        }// end function

    }
}
