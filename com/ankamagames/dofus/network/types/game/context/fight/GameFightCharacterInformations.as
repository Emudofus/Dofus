package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightCharacterInformations extends GameFightFighterNamedInformations implements INetworkType
   {
      
      public function GameFightCharacterInformations() {
         this.alignmentInfos = new ActorAlignmentInformations();
         super();
      }
      
      public static const protocolId:uint = 46;
      
      public var level:uint = 0;
      
      public var alignmentInfos:ActorAlignmentInformations;
      
      public var breed:int = 0;
      
      override public function getTypeId() : uint {
         return 46;
      }
      
      public function initGameFightCharacterInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:uint=2, param5:Boolean=false, param6:GameFightMinimalStats=null, param7:String="", param8:PlayerStatus=null, param9:uint=0, param10:ActorAlignmentInformations=null, param11:int=0) : GameFightCharacterInformations {
         super.initGameFightFighterNamedInformations(param1,param2,param3,param4,param5,param6,param7,param8);
         this.level = param9;
         this.alignmentInfos = param10;
         this.breed = param11;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.level = 0;
         this.alignmentInfos = new ActorAlignmentInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightCharacterInformations(param1);
      }
      
      public function serializeAs_GameFightCharacterInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterNamedInformations(param1);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeShort(this.level);
            this.alignmentInfos.serializeAs_ActorAlignmentInformations(param1);
            param1.writeByte(this.breed);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightCharacterInformations(param1);
      }
      
      public function deserializeAs_GameFightCharacterInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.level = param1.readShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameFightCharacterInformations.level.");
         }
         else
         {
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserialize(param1);
            this.breed = param1.readByte();
            return;
         }
      }
   }
}
