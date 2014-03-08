package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayTaxCollectorInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayTaxCollectorInformations() {
         this.identification = new TaxCollectorStaticInformations();
         super();
      }
      
      public static const protocolId:uint = 148;
      
      public var identification:TaxCollectorStaticInformations;
      
      public var guildLevel:uint = 0;
      
      public var taxCollectorAttack:int = 0;
      
      override public function getTypeId() : uint {
         return 148;
      }
      
      public function initGameRolePlayTaxCollectorInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:TaxCollectorStaticInformations=null, param5:uint=0, param6:int=0) : GameRolePlayTaxCollectorInformations {
         super.initGameRolePlayActorInformations(param1,param2,param3);
         this.identification = param4;
         this.guildLevel = param5;
         this.taxCollectorAttack = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.identification = new TaxCollectorStaticInformations();
         this.taxCollectorAttack = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayTaxCollectorInformations(param1);
      }
      
      public function serializeAs_GameRolePlayTaxCollectorInformations(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(param1);
         param1.writeShort(this.identification.getTypeId());
         this.identification.serialize(param1);
         if(this.guildLevel < 0 || this.guildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         else
         {
            param1.writeByte(this.guildLevel);
            param1.writeInt(this.taxCollectorAttack);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayTaxCollectorInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayTaxCollectorInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.identification = ProtocolTypeManager.getInstance(TaxCollectorStaticInformations,_loc2_);
         this.identification.deserialize(param1);
         this.guildLevel = param1.readUnsignedByte();
         if(this.guildLevel < 0 || this.guildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GameRolePlayTaxCollectorInformations.guildLevel.");
         }
         else
         {
            this.taxCollectorAttack = param1.readInt();
            return;
         }
      }
   }
}
