package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.entities.interfaces.IAnimated;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.jerakine.interfaces.IObstacle;
    import com.ankamagames.jerakine.interfaces.ITransparency;
    import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.ColorTransform;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.types.data.Follower;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
    import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
    import flash.display.Bitmap;
    import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
    import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.messages.MessageHandler;
    import com.ankamagames.jerakine.types.enums.InteractionsEnum;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
    import com.ankamagames.atouin.entities.behaviours.movements.MountedMovementBehavior;
    import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.map.IDataMapProvider;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.pathfinding.Pathfinding;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
    import com.ankamagames.tiphon.display.TiphonAnimation;
    import com.ankamagames.dofus.datacenter.sounds.SoundBones;
    import com.ankamagames.tiphon.engine.TiphonEventsManager;
    import flash.events.Event;
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.entities.interfaces.*;

    public class AnimatedCharacter extends TiphonSprite implements IEntity, IMovable, IDisplayable, IAnimated, IInteractive, IRectangle, IObstacle, ITransparency, ICustomUnicNameGetter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
        private static const LUMINOSITY_FACTOR:Number = 1.2;
        private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR, LUMINOSITY_FACTOR, LUMINOSITY_FACTOR);
        private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
        private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1, 1, 1, AtouinConstants.OVERLAY_MODE_ALPHA);

        private var _id:int;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        private var _followers:Vector.<Follower>;
        private var _followed:AnimatedCharacter;
        private var _followersMovPath:Vector.<MovementPath>;
        private var _transparencyAllowed:Boolean = true;
        private var _name:String;
        private var _canSeeThrough:Boolean = false;
        protected var _movementBehavior:IMovementBehavior;
        protected var _displayBehavior:IDisplayBehavior;
        private var _bmpAlpha:Bitmap;
        private var _auraEntity:TiphonSprite;
        private var _visibleAura:Boolean = true;
        public var speedAdjust:Number = 0;
        public var slideOnNextMove:Boolean;

        public function AnimatedCharacter(nId:int, look:TiphonEntityLook, followed:AnimatedCharacter=null)
        {
            this.id = nId;
            name = ("AnimatedCharacter" + nId);
            this._followers = new Vector.<Follower>();
            this._followersMovPath = new Vector.<MovementPath>();
            this._followed = followed;
            super(look);
            this._name = ("entity::" + nId);
            this._displayBehavior = AtouinDisplayBehavior.getInstance();
            this._movementBehavior = WalkingMovementBehavior.getInstance();
            addEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            addEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, DirectionsEnum.DOWN_RIGHT);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function set id(nValue:int):void
        {
            this._id = nValue;
        }

        public function get customUnicName():String
        {
            return (this._name);
        }

        public function get position():MapPoint
        {
            return (this._position);
        }

        public function set position(oValue:MapPoint):void
        {
            var f:Follower;
            var lastPosition:MapPoint = this._position;
            this._position = oValue;
            if (!(lastPosition))
            {
                for each (f in this._followers)
                {
                    if (!(f.entity.position))
                    {
                        this.addFollower(f, true);
                    };
                };
            };
        }

        public function get movementBehavior():IMovementBehavior
        {
            return (this._movementBehavior);
        }

        public function set movementBehavior(oValue:IMovementBehavior):void
        {
            this._movementBehavior = oValue;
        }

        public function get followed():AnimatedCharacter
        {
            return (this._followed);
        }

        public function get displayBehaviors():IDisplayBehavior
        {
            return (this._displayBehavior);
        }

        public function set displayBehaviors(oValue:IDisplayBehavior):void
        {
            this._displayBehavior = oValue;
        }

        public function get displayed():Boolean
        {
            return (this._displayed);
        }

        public function get handler():MessageHandler
        {
            return (Kernel.getWorker());
        }

        public function get enabledInteractions():uint
        {
            return (((InteractionsEnum.CLICK | InteractionsEnum.OUT) | InteractionsEnum.OVER));
        }

        public function get isMoving():Boolean
        {
            return (this._movementBehavior.isMoving(this));
        }

        public function get absoluteBounds():IRectangle
        {
            return (this._displayBehavior.getAbsoluteBounds(this));
        }

        override public function get useHandCursor():Boolean
        {
            return (true);
        }

        public function get visibleAura():Boolean
        {
            return (this._visibleAura);
        }

        public function set visibleAura(visible:Boolean):void
        {
            var currentAnimation:String;
            if (this._visibleAura == visible)
            {
                return;
            };
            this._visibleAura = visible;
            if (visible)
            {
                currentAnimation = getAnimation();
                if (((((this._auraEntity) && (currentAnimation))) && (!((currentAnimation.indexOf("AnimStatique") == -1)))))
                {
                    this.addSubEntity(this._auraEntity, SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0);
                    this._auraEntity.restartAnimation(0);
                    this._auraEntity = null;
                };
            }
            else
            {
                this._auraEntity = (getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) as TiphonSprite);
                if (this._auraEntity)
                {
                    removeSubEntity(this._auraEntity);
                    super.finalize();
                };
            };
        }

        public function get hasAura():Boolean
        {
            if (((!((this._auraEntity == null))) || (!((getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) == null)))))
            {
                return (true);
            };
            return (false);
        }

        public function getIsTransparencyAllowed():Boolean
        {
            return (this._transparencyAllowed);
        }

        public function set transparencyAllowed(allowed:Boolean):void
        {
            this._transparencyAllowed = allowed;
        }

        public function get followers():Vector.<Follower>
        {
            return (this._followers);
        }

        private function onFirstError(e:TiphonEvent):void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            var dirList:Array = getAvaibleDirection(AnimationEnum.ANIM_STATIQUE);
            var dir:uint = DirectionsEnum.DOWN_RIGHT;
            while (dir < (DirectionsEnum.DOWN_RIGHT + 7))
            {
                if (dirList[(dir % 8)])
                {
                    setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, (dir % 8));
                };
                dir++;
            };
        }

        private function onFirstRender(e:TiphonEvent):void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
        }

        public function canSeeThrough():Boolean
        {
            return (this._canSeeThrough);
        }

        public function setCanSeeThrough(value:Boolean):void
        {
            this._canSeeThrough = value;
        }

        public function canWalkThrough():Boolean
        {
            return (this._canSeeThrough);
        }

        public function canWalkTo():Boolean
        {
            return (this._canSeeThrough);
        }

        public function move(path:MovementPath, callback:Function=null, movementBehavior:IMovementBehavior=null):void
        {
            var follower:Follower;
            var infos:GameContextActorInformations;
            var isCreatureMode:Boolean;
            var forbidenCellsId:Array;
            var rpContextFrame:RoleplayContextFrame;
            var ies:Vector.<InteractiveElement>;
            var ie:InteractiveElement;
            var mp:MapPoint;
            var iePos:int;
            var avaibleDirectionCount:uint;
            var endpoint:MapPoint;
            var followerPoint:MapPoint;
            var tryCount:uint;
            var followedMovPath:MovementPath;
            var firstDrawPath:Array;
            var followerPath:MovementPath;
            var i:uint;
            var storedMovementPath:MovementPath;
            var pElem:PathElement;
            var lastElement:PathElement;
            if (!(path.start.equals(this.position)))
            {
                _log.warn((((((("Unsynchronized position for entity " + this.id) + ", jumping from ") + this.position) + " to ") + path.start) + "."));
                this.jump(path.start);
            };
            var distance:uint = (path.path.length + 1);
            this._movementBehavior = movementBehavior;
            if (!(this._movementBehavior))
            {
                if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                {
                    infos = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
                    if ((infos is GameRolePlayHumanoidInformations))
                    {
                        if ((infos as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        };
                    }
                    else
                    {
                        if ((infos is GameRolePlayGroupMonsterInformations))
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        };
                    };
                };
                if (!(this._movementBehavior))
                {
                    if (distance > 3)
                    {
                        isCreatureMode = false;
                        if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                        {
                            isCreatureMode = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                        };
                        if (((!(isCreatureMode)) && (this.isMounted())))
                        {
                            this._movementBehavior = MountedMovementBehavior.getInstance();
                        }
                        else
                        {
                            this._movementBehavior = RunningMovementBehavior.getInstance(this.speedAdjust);
                        };
                    }
                    else
                    {
                        if (distance > 0)
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        }
                        else
                        {
                            return;
                        };
                    };
                };
            };
            var followerDirection:uint = path.end.advancedOrientationTo(this.position);
            var mapData:IDataMapProvider = DataMapProvider.getInstance();
            if (this._followers.length > 0)
            {
                forbidenCellsId = new Array();
                rpContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
                if (rpContextFrame != null)
                {
                    ies = rpContextFrame.entitiesFrame.interactiveElements;
                    for each (ie in ies)
                    {
                        if (ie)
                        {
                            mp = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                            if (mp)
                            {
                                iePos = mp.cellId;
                                forbidenCellsId.push(iePos);
                            };
                        };
                    };
                };
            };
            this._followersMovPath = new Vector.<MovementPath>();
            for each (follower in this._followers)
            {
                avaibleDirectionCount = this.getFollowerAvailiableDirectionNumber(follower);
                endpoint = path.end;
                forbidenCellsId.push(endpoint.cellId);
                if (((!((follower.type == Follower.TYPE_MONSTER))) && ((((((!(avaibleDirectionCount) < 8)) && (!((this._followers.indexOf(follower) == 0))))) && ((this._followersMovPath.length > 0))))))
                {
                    endpoint = this._followersMovPath[(this._followersMovPath.length - 1)].end;
                };
                followerDirection = endpoint.advancedOrientationTo(this.position);
                followerPoint = null;
                tryCount = 0;
                do 
                {
                    followerPoint = endpoint.getNearestFreeCellInDirection(followerDirection, mapData, false, false, true, forbidenCellsId);
                    followerDirection++;
                    followerDirection = (followerDirection % 8);
                } while (((!(followerPoint)) && ((++tryCount < 8))));
                if (followerPoint)
                {
                    if (((!((avaibleDirectionCount < 8))) && (!((follower.type == Follower.TYPE_MONSTER)))))
                    {
                        followerPath = new MovementPath();
                        if ((((this._followers.indexOf(follower) == 0)) || ((this._followersMovPath.length <= 0))))
                        {
                            followedMovPath = path;
                            firstDrawPath = followedMovPath.path.concat();
                            followerPath.end = followerPoint;
                            if (firstDrawPath.length > 0)
                            {
                                firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData, firstDrawPath[(firstDrawPath.length - 1)].step, followerPoint).path);
                            }
                            else
                            {
                                firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData, path.start, followerPoint).path);
                            };
                        }
                        else
                        {
                            followedMovPath = this._followersMovPath[(this._followersMovPath.length - 1)];
                            firstDrawPath = followedMovPath.path.concat();
                            if (followedMovPath.length > 0)
                            {
                                followerPath.end = followedMovPath.getPointAtIndex((followedMovPath.length - 1)).step;
                            }
                            else
                            {
                                followerPath.end = followedMovPath.start;
                            };
                        };
                        if (forbidenCellsId.indexOf(followerPath.end) != -1)
                        {
                            followerPath.end = followerPath.end.getNearestFreeCellInDirection(followerDirection, mapData, false, false, true, forbidenCellsId);
                        };
                        forbidenCellsId.push(followerPath.end.cellId);
                        followerPath.start = follower.entity.position;
                        if (firstDrawPath.length > 0)
                        {
                            followerPath.addPoint(new PathElement(follower.entity.position, follower.entity.position.orientationTo(firstDrawPath[0].step)));
                        }
                        else
                        {
                            followerPath.addPoint(new PathElement(follower.entity.position, follower.entity.position.orientationTo(path.start)));
                        };
                        i = 0;
                        while (i < (firstDrawPath.length - 1))
                        {
                            pElem = new PathElement();
                            pElem.step.x = firstDrawPath[i].step.x;
                            pElem.step.y = firstDrawPath[i].step.y;
                            pElem.orientation = firstDrawPath[i].step.orientationTo(firstDrawPath[(i + 1)].step);
                            followerPath.addPoint(pElem);
                            i++;
                        };
                        storedMovementPath = new MovementPath();
                        storedMovementPath.path = followerPath.path.concat();
                        storedMovementPath.end = followerPath.end;
                        storedMovementPath.start = followerPath.start;
                        this._followersMovPath.push(storedMovementPath);
                        if (this._followers.indexOf(follower) == 0)
                        {
                            lastElement = followerPath.getPointAtIndex((followerPath.length - 1));
                            lastElement.orientation = followerPath.getPointAtIndex((followerPath.length - 1)).step.orientationTo(followerPoint);
                        };
                        this.processMove(followerPath, new Array(follower.entity, followerPoint));
                    }
                    else
                    {
                        forbidenCellsId.push(followerPoint.cellId);
                        Pathfinding.findPath(mapData, follower.entity.position, followerPoint, !((avaibleDirectionCount < 8)), true, this.processMove, new Array(follower.entity, followerPoint));
                    };
                }
                else
                {
                    _log.warn("Unable to get a proper destination for the follower.");
                };
            };
            this._movementBehavior.move(this, path, callback);
        }

        private function processMove(followPath:MovementPath, args:Array):void
        {
            var _local_4:MapPoint;
            var follower:IMovable = args[0];
            if (((followPath) && ((followPath.path.length > 0))))
            {
                follower.movementBehavior = this._movementBehavior;
                follower.move(followPath, null, this._movementBehavior);
            }
            else
            {
                _local_4 = args[1];
                _log.warn((((("There was no path from " + follower.position) + " to ") + _local_4) + " for a follower. Jumping !"));
                follower.jump(_local_4);
            };
        }

        public function jump(newPosition:MapPoint):void
        {
            var fol:Follower;
            var mdp:IDataMapProvider;
            var mp:MapPoint;
            this._movementBehavior.jump(this, newPosition);
            for each (fol in this._followers)
            {
                mdp = DataMapProvider.getInstance();
                mp = this.position.getNearestFreeCell(mdp, false);
                if (!(mp))
                {
                    mp = this.position.getNearestFreeCell(mdp, true);
                    if (!(mp))
                    {
                        return;
                    };
                };
                fol.entity.jump(mp);
            };
        }

        public function stop(forceStop:Boolean=false):void
        {
            var fol:Follower;
            this._movementBehavior.stop(this, forceStop);
            for each (fol in this._followers)
            {
                fol.entity.stop(forceStop);
            };
        }

        public function display(strata:uint=10):void
        {
            var f:Follower;
            this._displayBehavior.display(this, strata);
            this._displayed = true;
            for each (f in this._followers)
            {
                if ((((f.entity is IDisplayable)) && (!(IDisplayable(f.entity).displayed))))
                {
                    IDisplayable(f.entity).display();
                };
            };
        }

        public function remove():void
        {
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((fef) && (fef.justSwitchingCreaturesFightMode)))
            {
                this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_DESTROY, this));
            };
            this.removeAllFollowers();
            this._displayed = false;
            this._movementBehavior.stop(this, true);
            this._displayBehavior.remove(this);
        }

        override public function destroy():void
        {
            this._followed = null;
            this.remove();
            super.destroy();
        }

        public function getRootEntity():AnimatedCharacter
        {
            if (this._followed)
            {
                return (this._followed.getRootEntity());
            };
            return (this);
        }

        public function removeAllFollowers():void
        {
            var iFollower:Follower;
            var dfollower:IDisplayable;
            var sprite:TiphonSprite;
            var num:int = this._followers.length;
            var i:int;
            while (i < num)
            {
                iFollower = this._followers[i];
                dfollower = (iFollower.entity as IDisplayable);
                if (dfollower)
                {
                    dfollower.remove();
                };
                sprite = (iFollower.entity as TiphonSprite);
                if (sprite)
                {
                    sprite.destroy();
                };
                i++;
            };
            this._followers = new Vector.<Follower>();
        }

        public function removeFollower(follower:Follower):void
        {
            var iFollower:Follower;
            var dfollower:IDisplayable;
            var sprite:TiphonSprite;
            var num:int = this._followers.length;
            var i:int;
            while (i < num)
            {
                iFollower = this._followers[i];
                if (follower == iFollower)
                {
                    dfollower = (iFollower.entity as IDisplayable);
                    if (dfollower)
                    {
                        dfollower.remove();
                    };
                    sprite = (iFollower.entity as TiphonSprite);
                    if (sprite)
                    {
                        sprite.destroy();
                    };
                    this._followers.splice(i, 1);
                    return;
                };
                i++;
            };
        }

        public function addFollower(follower:Follower, instantSync:Boolean=false):void
        {
            var followerIndex:*;
            var f:Follower;
            var _local_8:uint;
            var dfollower:IDisplayable;
            var found:Boolean;
            for each (f in this._followers)
            {
                if (f.entity.id == follower.entity.id)
                {
                    found = true;
                    break;
                };
            };
            if (!(found))
            {
                if (follower.type == Follower.TYPE_PET)
                {
                    this._followers.unshift(follower);
                }
                else
                {
                    _local_8 = this.getFollowerAvailiableDirectionNumber(follower);
                    if ((((_local_8 < 8)) || ((follower.type == Follower.TYPE_MONSTER))))
                    {
                        this._followers.push(follower);
                    }
                    else
                    {
                        if ((((this._followers.length == 0)) || (!((this._followers[0].type == Follower.TYPE_PET)))))
                        {
                            followerIndex = 0;
                        };
                        this._followers.splice(followerIndex, 0, follower);
                    };
                };
            };
            if (!(this.position))
            {
                return;
            };
            var mdp:IDataMapProvider = DataMapProvider.getInstance();
            var mp:MapPoint = this.position.getNearestFreeCell(mdp, false);
            if (!(mp))
            {
                mp = this.position.getNearestFreeCell(mdp, true);
                if (!(mp))
                {
                    return;
                };
            };
            if (follower.entity.position == null)
            {
                follower.entity.position = mp;
            };
            if ((follower.entity is IDisplayable))
            {
                dfollower = (follower.entity as IDisplayable);
                if (((this._displayed) && (!(dfollower.displayed))))
                {
                    dfollower.display();
                }
                else
                {
                    if (((!(this._displayed)) && (dfollower.displayed)))
                    {
                        dfollower.remove();
                    };
                };
            };
            if (mp.equals(follower.entity.position))
            {
                return;
            };
            if (instantSync)
            {
                follower.entity.jump(mp);
            }
            else
            {
                follower.entity.move(Pathfinding.findPath(mdp, follower.entity.position, mp, false, false));
            };
        }

        private function getFollowerAvailiableDirectionNumber(follower:Follower):uint
        {
            var b:Boolean;
            var avaibleDirection:Array = [];
            if ((follower.entity is TiphonSprite))
            {
                avaibleDirection = TiphonSprite(follower.entity).getAvaibleDirection();
            };
            var avaibleDirectionCount:uint;
            for each (b in avaibleDirection)
            {
                if (b)
                {
                    avaibleDirectionCount++;
                };
            };
            if (((avaibleDirection[1]) && (!(avaibleDirection[3]))))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[1])) && (avaibleDirection[3])))
            {
                avaibleDirectionCount++;
            };
            if (((avaibleDirection[7]) && (!(avaibleDirection[5]))))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[7])) && (avaibleDirection[5])))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[0])) && (avaibleDirection[4])))
            {
                avaibleDirectionCount++;
            };
            if (((avaibleDirection[0]) && (!(avaibleDirection[4]))))
            {
                avaibleDirectionCount++;
            };
            return (avaibleDirectionCount);
        }

        public function followersEqual(pEntityLooks:Vector.<EntityLook>):Boolean
        {
            var i:int;
            var _local_5:Follower;
            if (!(pEntityLooks))
            {
                return (false);
            };
            var nbLooks:int = pEntityLooks.length;
            var nbEqual:int;
            if (this._followers.length != nbLooks)
            {
                return (false);
            };
            for each (_local_5 in this._followers)
            {
                i = 0;
                while (i < nbLooks)
                {
                    if ((_local_5.entity as AnimatedCharacter).look.equals(EntityLookAdapter.fromNetwork(pEntityLooks[i])))
                    {
                        nbEqual++;
                        break;
                    };
                    i++;
                };
            };
            if (nbEqual != nbLooks)
            {
                return (false);
            };
            return (true);
        }

        public function isMounted():Boolean
        {
            var subEntities:Array = this.look.getSubEntities(true);
            if (!(subEntities))
            {
                return (false);
            };
            var mountedEntities:Array = subEntities[SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER];
            if (((!(mountedEntities)) || ((mountedEntities.length == 0))))
            {
                return (false);
            };
            return (true);
        }

        public function highLightCharacterAndFollower(value:Boolean):void
        {
            var entity:AnimatedCharacter;
            var rootEntity:AnimatedCharacter = this.getRootEntity();
            var num:int = rootEntity._followers.length;
            var i:int = -1;
            while (++i < num)
            {
                entity = (rootEntity._followers[i].entity as AnimatedCharacter);
                if (entity)
                {
                    entity.highLight(value);
                };
            };
            this.highLight(value);
        }

        public function highLight(value:Boolean):void
        {
            if (value)
            {
                transform.colorTransform = LUMINOSITY_TRANSFORM;
            }
            else
            {
                if (Atouin.getInstance().options.transparentOverlayMode)
                {
                    transform.colorTransform = TRANSPARENCY_TRANSFORM;
                }
                else
                {
                    transform.colorTransform = NORMAL_TRANSFORM;
                };
            };
        }

        public function showBitmapAlpha(alphaValue:Number):void
        {
            var bmpdt:BitmapData;
            var newCellSprite:Sprite;
            if (this._bmpAlpha == null)
            {
                bmpdt = new BitmapData(width, height, true, 0xFF0000);
                bmpdt.draw(this.bitmapData);
                this._bmpAlpha = new Bitmap(bmpdt);
                this._bmpAlpha.alpha = alphaValue;
                newCellSprite = InteractiveCellManager.getInstance().getCell(this.position.cellId);
                this._bmpAlpha.x = ((newCellSprite.x + (newCellSprite.width / 2)) - (this.width / 2));
                this._bmpAlpha.y = ((newCellSprite.y + newCellSprite.height) - this.height);
                this.parent.addChild(this._bmpAlpha);
                visible = false;
            };
        }

        public function hideBitmapAlpha():void
        {
            visible = true;
            if (((!((this._bmpAlpha == null))) && (StageShareManager.stage.contains(this._bmpAlpha))))
            {
                this.parent.removeChild(this._bmpAlpha);
                this._bmpAlpha = null;
            };
        }

        override public function addSubEntity(entity:DisplayObject, category:uint, slot:uint):void
        {
            if ((((((category == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND)) && ((slot == 0)))) && (!(this._visibleAura))))
            {
                this._auraEntity = (entity as TiphonSprite);
                return;
            };
            super.addSubEntity(entity, category, slot);
        }

        override protected function onAdded(e:Event):void
        {
            var name:String;
            var vsa:Vector.<SoundAnimation>;
            var sa:SoundAnimation;
            var dataSoundLabel:String;
            super.onAdded(e);
            var animation:TiphonAnimation = (e.target as TiphonAnimation);
            var soundBones:SoundBones = SoundBones.getSoundBonesById(look.getBone());
            if (soundBones)
            {
                name = getQualifiedClassName(animation);
                vsa = soundBones.getSoundAnimations(name);
                animation.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND, name);
                for each (sa in vsa)
                {
                    dataSoundLabel = (((TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN) + ((((!((sa.label == null))) && (!((sa.label == "null"))))) ? sa.label : "")) + TiphonEventsManager.BALISE_PARAM_END);
                    animation.spriteHandler.tiphonEventManager.addEvent(dataSoundLabel, sa.startFrame, name);
                };
            };
        }


    }
}//package com.ankamagames.dofus.types.entities

