﻿package com.ankamagames.dofus.logic.game.common.types
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;

    public class DofusShopObject implements IDataCenter 
    {

        protected var _id:int;
        protected var _name:String;
        protected var _description:String;

        public function DofusShopObject(data:Object)
        {
            if (data)
            {
                this.init(data);
            };
        }

        public function init(data:Object):void
        {
            this._id = data.id;
            this._name = data.name;
            this._description = data.description;
        }

        public function free():void
        {
            this._id = 0;
            this._name = null;
            this._description = null;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get description():String
        {
            return (this._description);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.types

