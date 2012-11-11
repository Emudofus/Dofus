package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class DofusEntities extends Object
    {
        private static const LOCALIZER_DEBUG:Boolean = true;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusEntities));
        private static var _atouin:Atouin = Atouin.getInstance();
        private static var _localizers:Vector.<IEntityLocalizer> = new Vector.<IEntityLocalizer>;

        public function DofusEntities()
        {
            return;
        }// end function

        public static function getEntity(param1:int) : IEntity
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in _localizers)
            {
                
                _loc_2 = _loc_3.getEntity(param1);
                if (_loc_2)
                {
                    return _loc_2;
                }
            }
            return _atouin.getEntity(param1);
        }// end function

        public static function registerLocalizer(param1:IEntityLocalizer) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = null;
            for each (_loc_4 in _localizers)
            {
                
                _loc_3 = getQualifiedClassName(_loc_4);
                if (_loc_3 == _loc_2)
                {
                    throw new Error("There\'s more than one " + _loc_3 + " localizer added to DofusEntites. Nope, that won\'t work.");
                }
            }
            _localizers.push(param1);
            return;
        }// end function

        public static function reset() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _localizers.length)
            {
                
                _loc_2 = _localizers[_loc_1];
                _loc_2.unregistered();
                _loc_1++;
            }
            _localizers = new Vector.<IEntityLocalizer>;
            return;
        }// end function

    }
}
