package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EnemyWrapper extends Object implements IDataCenter
    {
        private var _item:IgnoredInformations;
        public var name:String = "";
        public var id:int;
        public var state:int;
        public var lastConnection:uint = 0;
        public var online:Boolean = false;
        public var type:String = "Enemy";
        public var playerName:String = "";
        public var breed:uint = 0;
        public var sex:uint = 2;
        public var level:int = 0;
        public var alignmentSide:int = -1;
        public var guildName:String = "";

        public function EnemyWrapper(param1:IgnoredInformations)
        {
            this.state = PlayerStateEnum.GAME_TYPE_ROLEPLAY;
            this._item = param1;
            this.name = param1.accountName;
            this.id = param1.accountId;
            if (param1 is IgnoredOnlineInformations)
            {
                this.playerName = IgnoredOnlineInformations(param1).playerName;
                this.breed = IgnoredOnlineInformations(param1).breed;
                this.sex = IgnoredOnlineInformations(param1).sex ? (1) : (0);
                this.online = true;
            }
            return;
        }// end function

    }
}
