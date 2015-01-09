package com.ankamagames.dofus.datacenter.breeds
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.I18n;

    public class BreedRoleByBreed implements IDataCenter 
    {

        public static const MODULE:String = "BreedRoleByBreeds";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BreedRoleByBreed));

        public var breedId:int;
        public var roleId:int;
        public var descriptionId:uint;
        public var value:int;
        public var order:int;
        private var _description:String;


        public function get description():String
        {
            if (!(this._description))
            {
                this._description = I18n.getText(this.descriptionId);
            };
            return (this._description);
        }


    }
}//package com.ankamagames.dofus.datacenter.breeds

