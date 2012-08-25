package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.utils.*;

    public class LinkedCursorSpriteManager extends Object
    {
        private var items:Array;
        private var _mustBeRemoved:Array;
        private var _mustClean:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LinkedCursorSpriteManager));
        private static var _self:LinkedCursorSpriteManager;

        public function LinkedCursorSpriteManager()
        {
            this.items = new Array();
            this._mustBeRemoved = new Array();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function getItem(param1:String) : LinkedCursorData
        {
            return this.items[param1];
        }// end function

        public function addItem(param1:String, param2:LinkedCursorData, param3:Boolean = false) : void
        {
            this._mustBeRemoved[param1] = false;
            if (this.items[param1])
            {
                this.removeItem(param1);
            }
            this.items[param1] = param2;
            param2.sprite.mouseChildren = false;
            param2.sprite.mouseEnabled = false;
            if (param3)
            {
                Berilia.getInstance().strataSuperTooltip.addChild(param2.sprite);
            }
            else
            {
                Berilia.getInstance().strataTooltip.addChild(param2.sprite);
            }
            var _loc_4:* = StageShareManager.mouseX;
            var _loc_5:* = StageShareManager.mouseY;
            param2.sprite.x = (param2.lockX ? (param2.sprite.x) : (StageShareManager.mouseX)) - (param2.offset ? (param2.offset.x) : (param2.sprite.width / 2));
            param2.sprite.y = (param2.lockY ? (param2.sprite.y) : (StageShareManager.mouseY)) - (param2.offset ? (param2.offset.y) : (param2.sprite.height / 2));
            if (param2.lockX || param2.lockY)
            {
            }
            this.updateCursors();
            EnterFrameDispatcher.addEventListener(this.updateCursors, "updateCursors");
            return;
        }// end function

        public function removeItem(param1:String, param2:Boolean = false) : Boolean
        {
            if (!this.items[param1])
            {
                return false;
            }
            this._mustBeRemoved[param1] = true;
            if (param2)
            {
                this._mustClean = true;
                EnterFrameDispatcher.addEventListener(this.updateCursors, "updateCursors");
            }
            else
            {
                this.remove(param1);
            }
            return true;
        }// end function

        private function updateCursors(param1 = null) : void
        {
            var _loc_4:LinkedCursorData = null;
            var _loc_5:String = null;
            if (this._mustClean)
            {
                this._mustClean = false;
                for (_loc_5 in this._mustBeRemoved)
                {
                    
                    if (this._mustBeRemoved[_loc_5] && this.items[_loc_5])
                    {
                        this.remove(_loc_5);
                    }
                }
            }
            var _loc_2:* = StageShareManager.mouseX;
            var _loc_3:* = StageShareManager.mouseY;
            for each (_loc_4 in this.items)
            {
                
                if (_loc_4)
                {
                    if (!_loc_4.lockX)
                    {
                        _loc_4.sprite.x = _loc_2 + (_loc_4.offset ? (_loc_4.offset.x) : (0));
                    }
                    if (!_loc_4.lockY)
                    {
                        _loc_4.sprite.y = _loc_3 + (_loc_4.offset ? (_loc_4.offset.y) : (0));
                    }
                }
            }
            return;
        }// end function

        private function remove(param1:String) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = this.items[param1].sprite as DisplayObject;
            if (_loc_2.parent)
            {
                _loc_2.parent.removeChild(_loc_2);
            }
            this.items[param1] = null;
            delete this.items[param1];
            delete this._mustBeRemoved[param1];
            var _loc_3:Boolean = true;
            for (_loc_4 in this.items)
            {
                
                _loc_3 = false;
            }
            if (_loc_3)
            {
                EnterFrameDispatcher.removeEventListener(this.updateCursors);
            }
            return;
        }// end function

        public static function getInstance() : LinkedCursorSpriteManager
        {
            if (!_self)
            {
                _self = new LinkedCursorSpriteManager;
            }
            return _self;
        }// end function

    }
}
