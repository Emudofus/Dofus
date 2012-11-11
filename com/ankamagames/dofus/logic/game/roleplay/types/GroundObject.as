package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class GroundObject extends GameRolePlayActorInformations
    {
        public var object:Item;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GroundObject));

        public function GroundObject(param1:Item)
        {
            this.object = param1;
            return;
        }// end function

    }
}
