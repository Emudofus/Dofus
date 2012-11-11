package com.ankamagames.atouin.entities.behaviours.display
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class AtouinDisplayBehavior extends Object implements IDisplayBehavior
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AtouinDisplayBehavior));
        private static var _self:AtouinDisplayBehavior;

        public function AtouinDisplayBehavior()
        {
            if (_self != null)
            {
                throw new SingletonError("A singleton class shouldn\'t be instancied directly!");
            }
            return;
        }// end function

        public function display(param1:IDisplayable, param2:uint = 0) : void
        {
            var _loc_3:* = param1 as IEntity;
            EntitiesManager.getInstance().addAnimatedEntity(_loc_3.id, _loc_3, param2);
            return;
        }// end function

        public function remove(param1:IDisplayable) : void
        {
            EntitiesManager.getInstance().removeEntity((param1 as IEntity).id);
            return;
        }// end function

        public function getAbsoluteBounds(param1:IDisplayable) : IRectangle
        {
            return EntitiesDisplayManager.getInstance().getAbsoluteBounds(param1);
        }// end function

        public static function getInstance() : AtouinDisplayBehavior
        {
            if (_self == null)
            {
                _self = new AtouinDisplayBehavior;
            }
            return _self;
        }// end function

    }
}
