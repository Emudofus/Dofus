package com.ankamagames.dofus.internalDatacenter.connection
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;

    public class SubscriberGift implements IDataCenter 
    {

        private var _id:uint;
        private var _description:String;
        private var _uri:String;
        private var _link:String;

        public function SubscriberGift(id:uint, description:String, uri:String, link:String)
        {
            this._id = id;
            this._description = description;
            this._link = link;
            this._uri = uri;
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function get description():String
        {
            return (this._description);
        }

        public function get uri():String
        {
            return (this._uri);
        }

        public function get link():String
        {
            return (this._link);
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.connection

