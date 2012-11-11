package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ListView extends Object implements IInventoryView
    {
        protected var _view:Vector.<ItemWrapper>;
        protected var _hookLock:IHookLock;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ListView));

        public function ListView(param1:IHookLock)
        {
            this._view = new Vector.<ItemWrapper>;
            this._hookLock = param1;
            return;
        }// end function

        public function get name() : String
        {
            throw new Error("get name() is abstract method, it should be implemented");
        }// end function

        public function initialize(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:* = null;
            this._view.splice(0, this._view.length);
            for each (_loc_2 in param1)
            {
                
                this._view.push(_loc_2);
            }
            this.updateView();
            return;
        }// end function

        public function get content() : Vector.<ItemWrapper>
        {
            return this._view;
        }// end function

        public function addItem(param1:ItemWrapper, param2:int) : void
        {
            this._view.push(param1);
            this.updateView();
            return;
        }// end function

        public function removeItem(param1:ItemWrapper, param2:int) : void
        {
            var _loc_3:* = this._view.indexOf(param1);
            if (_loc_3 == -1)
            {
                throw new Error("Demande de suppression d\'un item (id " + param1.objectUID + ") qui n\'existe pas dans la vue " + this.name);
            }
            this._view.splice(_loc_3, 1);
            return;
        }// end function

        public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void
        {
            var _loc_4:* = this._view.indexOf(param1);
            if (this._view.indexOf(param1) == -1)
            {
                throw new Error("Demande de modification d\'un item (id " + param1.objectUID + ") qui n\'existe pas dans la vue " + this.name);
            }
            this._view[_loc_4] = param1;
            return;
        }// end function

        public function isListening(param1:ItemWrapper) : Boolean
        {
            throw new Error("isListening() is abstract method, it should be implemented");
        }// end function

        public function updateView() : void
        {
            throw new Error("updateView() is abstract method, it should be implemented");
        }// end function

        public function empty() : void
        {
            this._view = new Vector.<ItemWrapper>;
            this.updateView();
            return;
        }// end function

    }
}
