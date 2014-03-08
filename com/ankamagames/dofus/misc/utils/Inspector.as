package com.ankamagames.dofus.misc.utils
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.atouin.types.FrustumShape;
   import flash.display.Stage;
   import com.ankamagames.berilia.Berilia;
   import flash.display.InteractiveObject;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   
   public class Inspector extends Object
   {
      
      public function Inspector() {
         this._tooltipTf = new TextField();
         this._tooltip = new Sprite();
         this._berilaChangedInteraction = new Dictionary(true);
         super();
         this._tooltip.mouseEnabled = false;
         this._tooltipTf.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat("Verdana");
         this._tooltipTf.defaultTextFormat = _loc1_;
         this._tooltipTf.setTextFormat(_loc1_);
         this._tooltipTf.multiline = true;
         this._tooltip.addChild(this._tooltipTf);
         this._tooltipTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private var _tooltipTf:TextField;
      
      private var _tooltip:Sprite;
      
      private var _enable:Boolean;
      
      private var _lastTarget:Vector.<InteractiveItem>;
      
      private var _currentShortCut:Vector.<ShortcutItem>;
      
      private var _berilaAllInteraction:Boolean;
      
      private var _berilaChangedInteraction:Dictionary;
      
      public function set enable(param1:Boolean) : void {
         if(param1)
         {
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onRollover);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         else
         {
            this.onRollout(this._lastTarget);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onRollover);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         this._enable = param1;
      }
      
      public function get enable() : Boolean {
         return this._enable;
      }
      
      private function onRollout(param1:*) : void {
         var _loc2_:InteractiveItem = null;
         for each (_loc2_ in this._lastTarget)
         {
            _loc2_.cleanHighlight();
         }
         this._currentShortCut = null;
         if(this._tooltip.parent)
         {
            StageShareManager.stage.removeChild(this._tooltip);
         }
      }
      
      private function onRollover(param1:MouseEvent) : void {
         var item:InteractiveItem = null;
         var currentTooltipStr:String = null;
         var rawTooltipStr:String = null;
         var s:ShortcutItem = null;
         var e:MouseEvent = param1;
         this._lastTarget = this.findElements(e.target as DisplayObject);
         var tooltipStr:String = "";
         var ind:String = "";
         var i:uint = 0;
         while(i < this._lastTarget.length)
         {
            item = this._lastTarget[i];
            item.highlight(i,this._lastTarget);
            currentTooltipStr = (tooltipStr.length?"<br/><br/>":"") + item.tooltip();
            currentTooltipStr = currentTooltipStr.split("<br/>").join("<br/>" + ind);
            tooltipStr = tooltipStr + currentTooltipStr;
            ind = ind + "&nbsp;&nbsp;&nbsp;";
            i++;
         }
         this._currentShortCut = null;
         if(this._lastTarget.length)
         {
            rawTooltipStr = tooltipStr;
            this._currentShortCut = this._lastTarget[0].shortcuts?this._lastTarget[0].shortcuts.concat():new Vector.<ShortcutItem>();
            this._currentShortCut.unshift(new ShortcutItem("Copier toutes les informations",Keyboard.C,function():void
            {
               var _loc1_:* = new TextField();
               _loc1_.htmlText = rawTooltipStr.split("<br/>").join("\n");
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,_loc1_.text);
            },true,false,false));
            this._currentShortCut.unshift(new ShortcutItem("Activer l\'inspection avancée",Keyboard.Z,function():void
            {
               changeBeriliaInteraction();
            },true,true,false));
            tooltipStr = tooltipStr + "<br/>-----------------------";
            for each (s in this._currentShortCut)
            {
               tooltipStr = tooltipStr + ("<br/>" + s.toString());
            }
         }
         if(tooltipStr.length)
         {
            this._tooltipTf.htmlText = tooltipStr;
            this._tooltip.graphics.clear();
            this._tooltip.graphics.beginFill(16777215,0.9);
            this._tooltip.graphics.lineStyle(1,0,0.7);
            this._tooltip.graphics.drawRect(-5,-5,this._tooltipTf.width * 1.1 + 10,this._tooltipTf.textHeight * 1.1 + 10);
            this._tooltip.graphics.endFill();
            if(this._lastTarget.length)
            {
               this._tooltip.x = StageShareManager.mouseX;
               this._tooltip.y = StageShareManager.mouseY - this._tooltip.height - 5;
               if(this._tooltip.y < 0)
               {
                  this._tooltip.y = 5;
               }
               if(this._tooltip.x + this._tooltip.width > StageShareManager.startWidth)
               {
                  this._tooltip.x = this._tooltip.x + (StageShareManager.startWidth - (this._tooltip.x + this._tooltip.width));
               }
            }
            else
            {
               this._tooltip.x = this._tooltip.y = 0;
            }
            StageShareManager.stage.addChild(this._tooltip);
         }
      }
      
      private function findElements(param1:DisplayObject) : Vector.<InteractiveItem> {
         var _loc3_:InteractiveItem = null;
         var _loc2_:Vector.<InteractiveItem> = new Vector.<InteractiveItem>();
         var _loc4_:* = "";
         while((param1) && (!(param1 is Stage)) && (param1.parent))
         {
            switch(true)
            {
               case param1 is UiRootContainer:
               case param1 is GraphicContainer:
                  _loc3_ = new InteractiveItemUi();
                  _loc3_.target = param1;
                  _loc2_.push(_loc3_);
                  break;
               case param1 is GraphicCell:
               case param1 is CellContainer:
                  _loc3_ = new InteractiveItemCell();
                  _loc3_.target = param1;
                  _loc2_.push(_loc3_);
                  break;
               case param1 is AnimatedCharacter:
                  _loc3_ = new InteractiveItemEntity();
                  _loc3_.target = param1;
                  _loc2_.push(_loc3_);
                  _loc3_ = new InteractiveItemCell();
                  _loc3_.target = InteractiveCellManager.getInstance().getCell(AnimatedCharacter(param1).position.cellId);
                  _loc2_.push(_loc3_);
                  break;
               case param1 is SpriteWrapper:
                  _loc3_ = new InteractiveItemElement();
                  _loc3_.target = param1;
                  _loc2_.push(_loc3_);
                  break;
               case param1 is FrustumShape:
                  _loc3_ = new InteractiveItemMapBorder();
                  _loc3_.target = param1;
                  _loc2_.push(_loc3_);
                  break;
            }
            param1 = param1.parent;
         }
         return _loc2_;
      }
      
      private function changeBeriliaInteraction() : void {
         var _loc1_:* = undefined;
         this._berilaAllInteraction = !this._berilaAllInteraction;
         if(this._berilaAllInteraction)
         {
            this.changeInteraction(Berilia.getInstance().docMain);
         }
         else
         {
            for (_loc1_ in this._berilaChangedInteraction)
            {
               if(_loc1_ is InteractiveObject && this._berilaChangedInteraction[_loc1_] == 1 || this._berilaChangedInteraction[_loc1_] == 3)
               {
                  InteractiveObject(_loc1_).mouseEnabled = false;
               }
               if(_loc1_ is DisplayObjectContainer && this._berilaChangedInteraction[_loc1_] > 1)
               {
                  DisplayObjectContainer(_loc1_).mouseChildren = false;
               }
            }
            this._berilaChangedInteraction = new Dictionary(true);
         }
      }
      
      private function changeInteraction(param1:DisplayObjectContainer) : void {
         var _loc3_:DisplayObject = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is InteractiveObject && !InteractiveObject(_loc3_).mouseEnabled)
            {
               InteractiveObject(_loc3_).mouseEnabled = true;
               this._berilaChangedInteraction[_loc3_] = 1;
            }
            if(_loc3_ is DisplayObjectContainer)
            {
               if(!DisplayObjectContainer(_loc3_).mouseChildren)
               {
                  DisplayObjectContainer(_loc3_).mouseChildren = true;
                  this._berilaChangedInteraction[_loc3_] = this._berilaChangedInteraction[_loc3_] + 2;
               }
               this.changeInteraction(_loc3_ as DisplayObjectContainer);
            }
            _loc2_++;
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void {
         var _loc2_:ShortcutItem = null;
         if((this._lastTarget) && (this._lastTarget.length) && (this._currentShortCut))
         {
            for each (_loc2_ in this._currentShortCut)
            {
               if(_loc2_.ctrl == param1.ctrlKey && _loc2_.shift == param1.shiftKey && _loc2_.alt == param1.altKey && _loc2_.key == param1.keyCode)
               {
                  _loc2_.callback();
               }
            }
         }
      }
   }
}
class ShortcutItem extends Object
{
   
   function ShortcutItem(param1:String, param2:uint, param3:Function, param4:Boolean, param5:Boolean, param6:Boolean) {
      super();
      this.legend = param1;
      this.key = param2;
      this.callback = param3;
      this.ctrl = param4;
      this.alt = param6;
      this.shift = param5;
   }
   
   public var legend:String;
   
   public var callback:Function;
   
   public var key:uint;
   
   public var ctrl:Boolean;
   
   public var shift:Boolean;
   
   public var alt:Boolean;
   
   public function toString() : String {
      var _loc1_:Array = [];
      if(this.ctrl)
      {
         _loc1_.push("ctrl");
      }
      if(this.alt)
      {
         _loc1_.push("alt");
      }
      if(this.shift)
      {
         _loc1_.push("shift");
      }
      _loc1_.push(String.fromCharCode(this.key));
      return _loc1_.join(" + ") + " : " + this.legend;
   }
}
import flash.display.Shape;
import flash.geom.ColorTransform;
import __AS3__.vec.Vector;
import flash.display.DisplayObject;
import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;

class InteractiveItem extends Object
{
   
   function InteractiveItem() {
      super();
   }
   
   protected static var _highlightShape:Shape = new Shape();
   
   protected static var _highlightShape2:Shape = new Shape();
   
   protected static var _highlightEffect:ColorTransform = new ColorTransform(1.2,1.2,1.2);
   
   protected static var _normalEffect:ColorTransform = new ColorTransform(1,1,1);
   
   public var shortcuts:Vector.<ShortcutItem>;
   
   public var target:DisplayObject;
   
   public function highlight(param1:uint, param2:Vector.<InteractiveItem>) : void {
   }
   
   public function cleanHighlight() : void {
   }
   
   public function tooltip() : String {
      return "";
   }
   
   protected function toClipboard(param1:String) : void {
      Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,param1);
   }
}
import __AS3__.vec.Vector;
import flash.geom.Rectangle;
import com.ankamagames.berilia.types.graphic.UiRootContainer;
import com.ankamagames.jerakine.utils.display.StageShareManager;
import com.ankamagames.berilia.components.Grid;
import com.ankamagames.berilia.components.ComboBox;
import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
import avmplus.getQualifiedClassName;
import com.ankamagames.berilia.managers.UiSoundManager;
import com.ankamagames.berilia.types.graphic.GraphicContainer;
import flash.ui.Keyboard;

class InteractiveItemUi extends InteractiveItem
{
   
   function InteractiveItemUi() {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard("click( UiHelper.get(\"" + GraphicContainer(target).getUi().uiData.name + "\"), \"" + GraphicContainer(target).customUnicName + "\");");
      },true,true,false),new ShortcutItem("Cmd son survol",Keyboard.S,function():void
      {
         if(target is Grid || target is ComboBox)
         {
            toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onItemRollOver [ID_SON]");
         }
         else
         {
            toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onRollOver [ID_SON]");
         }
      },true,true,false),new ShortcutItem("Cmd son click",Keyboard.X,function():void
      {
         toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onRelease [ID_SON]");
      },true,true,false),new ShortcutItem("Cmd inspecter element",Keyboard.A,function():void
      {
         toClipboard("/inspectuielement " + GraphicContainer(target).getUi().uiData.name + " " + target.name);
      },true,true,false)]);
   }
   
   override public function highlight(param1:uint, param2:Vector.<InteractiveItem>) : void {
      var _loc4_:Rectangle = null;
      var _loc6_:InteractiveItem = null;
      var _loc3_:* = param1 == 0;
      var _loc5_:* = true;
      for each (_loc6_ in param2)
      {
         if(_loc6_.target == target)
         {
            break;
         }
         if(_loc6_ is InteractiveItemUi && !(_loc6_.target == target))
         {
            _loc5_ = false;
            break;
         }
      }
      if(target is UiRootContainer)
      {
         if(!_loc5_)
         {
            _loc5_ = true;
            StageShareManager.stage.addChild(_highlightShape2);
            _loc4_ = target.getBounds(StageShareManager.stage);
            _highlightShape2.graphics.clear();
            _highlightShape2.graphics.lineStyle(2,255,0.7);
            _highlightShape2.graphics.beginFill(255,0);
            _highlightShape2.graphics.drawRect(_loc4_.left,_loc4_.top,_loc4_.width,_loc4_.height);
            _highlightShape2.graphics.endFill();
         }
      }
      else
      {
         if(!_loc3_)
         {
            StageShareManager.stage.addChild(_highlightShape);
            _loc4_ = target.getBounds(StageShareManager.stage);
            _highlightShape.graphics.clear();
            _highlightShape.graphics.lineStyle(3,0,0.7);
            _highlightShape.graphics.beginFill(16711680,0.0);
            _highlightShape.graphics.drawRect(_loc4_.left,_loc4_.top,_loc4_.width,_loc4_.height);
            _highlightShape.graphics.endFill();
         }
         else
         {
            if(target is Grid || target is ComboBox)
            {
            }
         }
      }
   }
   
   override public function cleanHighlight() : void {
      if(_highlightShape2.parent)
      {
         StageShareManager.stage.removeChild(_highlightShape2);
      }
      if(_highlightShape.parent)
      {
         StageShareManager.stage.removeChild(_highlightShape);
      }
      target.transform.colorTransform = _normalEffect;
   }
   
   override public function tooltip() : String {
      var _loc3_:UiRootContainer = null;
      var _loc4_:Vector.<BeriliaUiElementSound> = null;
      var _loc5_:BeriliaUiElementSound = null;
      var _loc1_:* = "";
      var _loc2_:* = "#0";
      if(target.name.indexOf("instance") == 0)
      {
         _loc2_ = "#FF0000";
      }
      if(target is UiRootContainer)
      {
         _loc3_ = target as UiRootContainer;
         _loc1_ = _loc1_ + "<b><font color=\'#62AAA6\'>Interface</font></b><br/>";
         if(_loc3_.uiData)
         {
            _loc1_ = _loc1_ + ("<b>Nom : </b>" + _loc3_.uiData.name + "<br/>");
            _loc1_ = _loc1_ + ("<b>Module : </b>" + _loc3_.uiData.module.id + "<br/>");
            _loc1_ = _loc1_ + ("<b>Script : </b>" + _loc3_.uiData.uiClassName + "<br/>");
         }
         else
         {
            _loc1_ = _loc1_ + "<b>Aucune information</b><br/>";
         }
      }
      else
      {
         _loc1_ = _loc1_ + "<b><font color=\'#964D8C\'>Composant</font></b><br/>";
         _loc1_ = _loc1_ + ("<b>Nom : </b><font color=\'" + _loc2_ + "\'>" + target.name + "</font><br/>");
         _loc1_ = _loc1_ + ("<b>Type : </b>" + getQualifiedClassName(target).split("::").pop() + "<br/>");
         _loc4_ = UiSoundManager.getInstance().getAllSoundUiElement(target as GraphicContainer);
         _loc1_ = _loc1_ + ("<b>Sons : </b>" + (_loc4_.length?"":"Aucun") + "");
         if(_loc4_.length)
         {
            for each (_loc5_ in _loc4_)
            {
               _loc1_ = _loc1_ + ("<br/>&nbsp;&nbsp;&nbsp; - " + _loc5_.hook + " : " + _loc5_.file);
            }
         }
      }
      return _loc1_;
   }
}
import com.ankamagames.atouin.types.Selection;
import com.ankamagames.atouin.renderers.ZoneDARenderer;
import com.ankamagames.jerakine.types.Color;
import com.ankamagames.jerakine.types.positions.MapPoint;
import com.ankamagames.atouin.utils.DataMapProvider;
import com.ankamagames.atouin.data.map.CellData;
import com.ankamagames.atouin.managers.MapDisplayManager;
import __AS3__.vec.Vector;
import com.ankamagames.jerakine.types.zones.Custom;
import com.ankamagames.atouin.managers.SelectionManager;
import flash.ui.Keyboard;

class InteractiveItemCell extends InteractiveItem
{
   
   function InteractiveItemCell() {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard("click( CellHelper.get( " + Object(target).cellId + " );");
      },true,true,false)]);
   }
   
   private static var SELECTION_NAME:String = "InteractiveItemCellHighlight";
   
   private static var _selection:Selection = new Selection();
   
   override public function tooltip() : String {
      var _loc1_:uint = Object(target).cellId;
      var _loc2_:MapPoint = MapPoint.fromCellId(_loc1_);
      var _loc3_:* = "<b><font color=\'#66572D\'>Cell " + _loc1_ + "</font></b> (" + _loc2_.x + "/" + _loc2_.y + ")";
      _loc3_ = _loc3_ + ("<br/>Ligne de vue : " + !DataMapProvider.getInstance().pointLos(_loc2_.x,_loc2_.y));
      _loc3_ = _loc3_ + ("<br/>Blocage éditeur : " + !DataMapProvider.getInstance().pointMov(_loc2_.x,_loc2_.y));
      _loc3_ = _loc3_ + ("<br/>Blocage entitée : " + !DataMapProvider.getInstance().pointMov(_loc2_.x,_loc2_.y,false));
      var _loc4_:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc1_]);
      if((_loc4_.useBottomArrow) || (_loc4_.useTopArrow) || (_loc4_.useRightArrow) || (_loc4_.useLeftArrow))
      {
         _loc3_ = _loc3_ + ("<br/>Forcage fleche bas : " + _loc4_.useBottomArrow);
         _loc3_ = _loc3_ + ("<br/>Forcage fleche haut : " + _loc4_.useTopArrow);
         _loc3_ = _loc3_ + ("<br/>Forcage fleche droite : " + _loc4_.useRightArrow);
         _loc3_ = _loc3_ + ("<br/>Forcage fleche gauche : " + _loc4_.useLeftArrow);
      }
      _loc3_ = _loc3_ + ("<br/>ID de zone : " + _loc4_.moveZone);
      _loc3_ = _loc3_ + ("<br/>Hauteur : " + _loc4_.floor + " px");
      _loc3_ = _loc3_ + ("<br/>Speed : " + _loc4_.speed);
      return _loc3_;
   }
   
   override public function cleanHighlight() : void {
      _selection.remove();
   }
   
   override public function highlight(param1:uint, param2:Vector.<InteractiveItem>) : void {
      _selection.zone = new Custom(Vector.<uint>([Object(target).cellId]));
      SelectionManager.getInstance().addSelection(_selection,SELECTION_NAME,Object(target).cellId);
   }
}
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
import flash.utils.Dictionary;
import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
import com.ankamagames.dofus.datacenter.npcs.Npc;
import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
import __AS3__.vec.Vector;
import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
import com.ankamagames.dofus.datacenter.npcs.NpcAction;
import com.ankamagames.dofus.datacenter.monsters.Monster;
import com.ankamagames.dofus.kernel.Kernel;
import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
import flash.ui.Keyboard;
import flash.net.navigateToURL;
import flash.net.URLRequest;

class InteractiveItemEntity extends InteractiveItem
{
   
   function InteractiveItemEntity() {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   private var _cmd:String;
   
   override public function tooltip() : String {
      var entities:Dictionary = null;
      var info:GameContextActorInformations = null;
      var npc:Npc = null;
      var monsterGroup:GameRolePlayGroupMonsterInformations = null;
      var monsters:Vector.<MonsterInGroupLightInformations> = null;
      var npcAction:NpcAction = null;
      var action:uint = 0;
      var m:MonsterInGroupLightInformations = null;
      var monster:Monster = null;
      var e:IEntity = target as IEntity;
      var str:String = "<b>Entity " + e.id + "</b>";
      var entityFrame:AbstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      if(!entityFrame)
      {
         entityFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      if(entityFrame)
      {
         entities = entityFrame.getEntitiesDictionnary();
      }
      else
      {
         entities = new Dictionary();
      }
      info = entities[e.id];
      this._cmd = "click( EntityHelper.get( " + e.id + " ) );";
      if(info)
      {
         switch(true)
         {
            case info is GameRolePlayNpcInformations:
               npc = Npc.getNpcById(GameRolePlayNpcInformations(info).npcId);
               str = "<b><font color=\'#4F8230\'>PNJ " + npc.name + "</font></b><br/>";
               str = str + ("Npc Id: " + npc.id + "<br/>");
               str = str + ("Entity Id: " + e.id + "<br/>");
               str = str + ("look: " + npc.look);
               if((npc.actions) && npc.actions.length > 0)
               {
                  for each (action in npc.actions)
                  {
                     npcAction = NpcAction.getNpcActionById(action);
                     str = str + ("<br/> Skill : " + npcAction.name + " (id: " + npcAction.id + ")");
                  }
               }
               this._cmd = "$(\"On parle avec le Pnj " + npc.name + " (id: " + npc.id + ")\" );\n";
               this._cmd = this._cmd + ("npcDialog( EntityHelper.getNpc( " + npc.id + " ), rep1, rep2, ... );");
               shortcuts.push(new ShortcutItem("Ouvrir l\'admin lite de ce PNJ",Keyboard.A,function():void
               {
                  navigateToURL(new URLRequest("http://dofus.adminslite.lan:8080/admin?type=1402&value=" + npc.id + "&lang=fr"));
               },true,true,false));
               break;
            case info is GameRolePlayGroupMonsterInformations:
               str = "<b><font color=\'#ED4A61\'>Groupe de monstre</font></b><br/>";
               str = str + ("id: " + e.id + "<br/>");
               monsterGroup = info as GameRolePlayGroupMonsterInformations;
               monsters = Vector.<MonsterInGroupLightInformations>([monsterGroup.staticInfos.mainCreatureLightInfos]);
               monsters = monsters.concat(monsterGroup.staticInfos.underlings);
               for each (m in monsters)
               {
                  monster = Monster.getMonsterById(m.creatureGenericId);
                  str = str + ("<br/> " + monster.name + " (id: " + monster.id + ", lvl: " + monster.getMonsterGrade(m.grade).level + ", look: " + monster.look + ")");
               }
               break;
         }
      }
      return str;
   }
}
import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
import com.ankamagames.dofus.kernel.Kernel;
import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
import __AS3__.vec.Vector;
import com.ankamagames.atouin.Atouin;
import com.ankamagames.dofus.datacenter.jobs.Skill;
import flash.ui.Keyboard;

class InteractiveItemElement extends InteractiveItem
{
   
   function InteractiveItemElement() {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   private var _cmd:String;
   
   override public function tooltip() : String {
      var _loc4_:InteractiveElement = null;
      var _loc5_:InteractiveElementSkill = null;
      var _loc6_:String = null;
      var _loc1_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      if(!_loc1_)
      {
         return "";
      }
      var _loc2_:Vector.<InteractiveElement> = _loc1_.interactiveElements;
      var _loc3_:Vector.<InteractiveElement> = new Vector.<InteractiveElement>();
      for each (_loc4_ in _loc2_)
      {
         if(Atouin.getInstance().getIdentifiedElement(_loc4_.elementId) == target)
         {
            this._cmd = "click( InteractiveElementHelper.get( " + _loc4_.elementId + " ) );";
            _loc6_ = "<b><font color=\'#2A49AA\'>Element " + _loc4_.elementId + "</font></b>";
            for each (_loc5_ in _loc4_.enabledSkills)
            {
               _loc6_ = _loc6_ + ("<br/> Skill : " + Skill.getSkillById(_loc5_.skillId).name + " (id: " + Skill.getSkillById(_loc5_.skillId).id + ")");
            }
            for each (_loc5_ in _loc4_.disabledSkills)
            {
               _loc6_ = _loc6_ + ("<br/> Skill disable : " + Skill.getSkillById(_loc5_.skillId).name + " (id: " + Skill.getSkillById(_loc5_.skillId).id + ")");
            }
            return _loc6_;
         }
      }
      return null;
   }
}
import com.ankamagames.atouin.types.FrustumShape;
import com.ankamagames.atouin.managers.FrustumManager;
import com.ankamagames.jerakine.types.enums.DirectionsEnum;
import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
import flash.ui.Keyboard;

class InteractiveItemMapBorder extends InteractiveItem
{
   
   function InteractiveItemMapBorder() {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   private var _cmd:String;
   
   override public function tooltip() : String {
      var _loc2_:uint = 0;
      var _loc1_:FrustumShape = target as FrustumShape;
      switch(target)
      {
         case FrustumManager.getInstance().getShape(DirectionsEnum.LEFT):
         case FrustumManager.getInstance().getShape(DirectionsEnum.RIGHT):
            _loc2_ = Math.round(_loc1_.mouseY / _loc1_.height * 100);
            break;
         case FrustumManager.getInstance().getShape(DirectionsEnum.UP):
         case FrustumManager.getInstance().getShape(DirectionsEnum.DOWN):
            _loc2_ = Math.round(_loc1_.mouseX / _loc1_.width * 100);
            break;
      }
      var _loc3_:* = "<b><font color=\'#40BD00\'>Bord de map " + DescribeTypeCache.getConstantName(DirectionsEnum,_loc1_.direction) + " (" + _loc2_ + "%)</font></b>";
      return _loc3_;
   }
}
