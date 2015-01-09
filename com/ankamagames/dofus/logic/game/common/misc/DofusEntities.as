package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.Atouin;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import __AS3__.vec.*;

    public class DofusEntities 
    {

        private static const LOCALIZER_DEBUG:Boolean = true;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusEntities));
        private static var _atouin:Atouin = Atouin.getInstance();
        private static var _localizers:Vector.<IEntityLocalizer> = new Vector.<IEntityLocalizer>();


        public static function getEntity(entityId:int):IEntity
        {
            var localizer:IEntityLocalizer;
            var foundEntity:IEntity;
            for each (localizer in _localizers)
            {
                foundEntity = localizer.getEntity(entityId);
                if (foundEntity)
                {
                    return (foundEntity);
                };
            };
            return (_atouin.getEntity(entityId));
        }

        public static function registerLocalizer(localizer:IEntityLocalizer):void
        {
            var currentLocalizer:IEntityLocalizer;
            var clazz:String = getQualifiedClassName(localizer);
            var currentClazz:String;
            for each (currentLocalizer in _localizers)
            {
                currentClazz = getQualifiedClassName(currentLocalizer);
                if (currentClazz == clazz)
                {
                    throw (new Error((("There's more than one " + currentClazz) + " localizer added to DofusEntites. Nope, that won't work.")));
                };
            };
            _localizers.push(localizer);
        }

        public static function reset():void
        {
            var localizer:IEntityLocalizer;
            var i:int;
            while (i < _localizers.length)
            {
                localizer = _localizers[i];
                localizer.unregistered();
                i++;
            };
            _localizers = new Vector.<IEntityLocalizer>();
        }


    }
}//package com.ankamagames.dofus.logic.game.common.misc

