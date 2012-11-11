package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class FriendWrapper extends Object implements IDataCenter
    {
        private var _item:FriendInformations;
        public var name:String;
        public var id:int;
        public var state:int;
        public var lastConnection:uint;
        public var online:Boolean = false;
        public var type:String = "Friend";
        public var playerName:String = "";
        public var level:int = 0;
        public var moodSmileyId:int = -1;
        public var alignmentSide:int = 0;
        public var breed:uint = 0;
        public var sex:uint = 2;
        public var realGuildName:String = "";
        public var guildName:String = "";

        public function FriendWrapper(param1:FriendInformations)
        {
            this._item = param1;
            this.name = param1.accountName;
            this.id = param1.accountId;
            this.state = param1.playerState;
            this.lastConnection = param1.lastConnection;
            if (param1 is FriendOnlineInformations)
            {
                this.playerName = FriendOnlineInformations(param1).playerName;
                this.level = FriendOnlineInformations(param1).level;
                this.alignmentSide = FriendOnlineInformations(param1).alignmentSide;
                this.breed = FriendOnlineInformations(param1).breed;
                this.sex = FriendOnlineInformations(param1).sex ? (1) : (0);
                if (FriendOnlineInformations(param1).guildInfo.guildName == "#NONAME#")
                {
                    this.guildName = I18n.getUiText("ui.guild.noName");
                }
                else
                {
                    this.guildName = FriendOnlineInformations(param1).guildInfo.guildName;
                }
                this.realGuildName = FriendOnlineInformations(param1).guildInfo.guildName;
                this.moodSmileyId = FriendOnlineInformations(param1).moodSmileyId;
                this.online = true;
            }
            return;
        }// end function

    }
}
