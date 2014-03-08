package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalAllianceInformations extends CharacterMinimalGuildInformations implements INetworkType
   {
      
      public function CharacterMinimalAllianceInformations() {
         this.alliance = new BasicAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 444;
      
      public var alliance:BasicAllianceInformations;
      
      override public function getTypeId() : uint {
         return 444;
      }
      
      public function initCharacterMinimalAllianceInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:BasicGuildInformations=null, param6:BasicAllianceInformations=null) : CharacterMinimalAllianceInformations {
         super.initCharacterMinimalGuildInformations(param1,param2,param3,param4,param5);
         this.alliance = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alliance = new BasicAllianceInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterMinimalAllianceInformations(param1);
      }
      
      public function serializeAs_CharacterMinimalAllianceInformations(param1:IDataOutput) : void {
         super.serializeAs_CharacterMinimalGuildInformations(param1);
         this.alliance.serializeAs_BasicAllianceInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterMinimalAllianceInformations(param1);
      }
      
      public function deserializeAs_CharacterMinimalAllianceInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserialize(param1);
      }
   }
}
