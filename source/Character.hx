package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxSort;
import Section.SwagSection;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'tankman':
				tex = Paths.getSparrowAtlas('characters/painttank__Captain');
				frames = tex;
				quickAnimAdd('idle', 'Tank Idle', 30);
				quickAnimAdd('singUP', 'Tank Up', 30);
				quickAnimAdd('singDOWN', 'Tank Down', 30);
				quickAnimAdd('singLEFT', 'tank right', 30);
				quickAnimAdd('singRIGHT', 'Tank Left', 30);
				quickAnimAdd('singUP-alt', 'Tank Ugh', 30);
				
				playAnim('idle');
				
				setGraphicSize(Std.int(width * 1.1));
				antialiasing = false;
				updateHitbox();
				
				flipX = true;
				
			case 'kiryu':
				tex = Paths.getSparrowAtlas('characters/Kiryu_night_funkin');
				frames = tex;
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up');
				quickAnimAdd('singRIGHT', 'Right');
				quickAnimAdd('singDOWN', 'Down');
				quickAnimAdd('singLEFT', 'Left');

				playAnim('idle');
				
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				quickAnimAdd('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				quickAnimAdd('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,false);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24,false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 30);
				addOffset("singRIGHT", 0, 7);
				addOffset("singLEFT", -10, -10);
				addOffset("singDOWN", 0, -10);

				playAnim('idle');
			case 'mickle':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('mickle');
				frames = tex;
				animation.addByPrefix('idle', 'mickle idle', 24,false);
				animation.addByPrefix('singUP', 'mickle up', 24);
				animation.addByPrefix('singRIGHT', 'mickle right', 24);
				animation.addByPrefix('singDOWN', 'mickle down', 24);
				animation.addByPrefix('singLEFT', 'mickle left', 24);

				addOffset('idle');
				addOffset("singUP", 0, -100);
				addOffset("singRIGHT", 0, -100);
				addOffset("singLEFT", 0, -100);
				addOffset("singDOWN", 0, -100);

				playAnim('idle');
			case 'agoti':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('AGOTIMS');
				frames = tex;
				animation.addByPrefix('idle', 'Agoti_Idle', 24,false);
				animation.addByPrefix('singUP', 'Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Agoti_Left', 24);

				addOffset("idle", -100, 0);
				addOffset("singUP", -100, 0);
				addOffset("singRIGHT", -100, 0);
				addOffset("singLEFT", -100, 0);
				addOffset("singDOWN", -100, 0);

				playAnim('idle');
			case 'bf-agoti':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('AGOTI');
				frames = tex;
				animation.addByPrefix('idle', 'Agoti_Idle', 24,false);
				animation.addByPrefix('singUP', 'Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Agoti_Left', 24);
				animation.addByPrefix('singUPmiss', 'Agoti_Up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Agoti_Left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Agoti_Right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Agoti_Down', 24, false);
				animation.addByPrefix('hey', 'Agoti_Up', 24, false);

				animation.addByPrefix('firstDeath', "Agoti_Idle", 24, false);
				animation.addByPrefix('deathLoop', "Agoti_Idle", 24, true);
				animation.addByPrefix('deathConfirm', "Agoti_Idle", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5, 600);
				addOffset("singUP", -29, 627);
				addOffset("singRIGHT", -38, 593);
				addOffset("singLEFT", 12, 594);
				addOffset("singDOWN", -10, 200);
				addOffset("singUPmiss", -29, 627);
				addOffset("singRIGHTmiss", -30, 621);
				addOffset("singLEFTmiss", 12, 624);
				addOffset("singDOWNmiss", -11, 581);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				quickAnimAdd('idle', 'Dad idle dance');
				quickAnimAdd('singUP', 'Dad Sing Note UP', 24);
				quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT', 24);
				quickAnimAdd('singDOWN', 'Dad Sing Note DOWN', 24);
				quickAnimAdd('singLEFT', 'Dad Sing Note LEFT', 24);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'spooky DOWN note');
				quickAnimAdd('singLEFT', 'note sing left');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				playAnim('danceRight');
				
			case 'spooky-pump':
				tex = Paths.getSparrowAtlas('FX/Blackout_Pump');
				frames = tex;
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'sorry nothing');
				quickAnimAdd('singLEFT', 'sorry nothing');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				playAnim('danceRight');
				
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');
				
				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				playAnim('idle');
				
			case 'mom-eyes':
				tex = Paths.getSparrowAtlas('FX/Night_Mom');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				playAnim('idle');

			case 'mom-car-eyes':
				tex = Paths.getSparrowAtlas('FX/Night_MomCar');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				playAnim('idle');
				
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');
				
				playAnim('idle');
				
			case 'monster-face':
				tex = Paths.getSparrowAtlas('FX/MonsterFace');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				playAnim('idle');
				
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				quickAnimAdd('idle', "Pico Idle Dance", 24);
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				quickAnimAdd('singLEFT', 'Pico Note Right0');
				quickAnimAdd('singRIGHT', 'Pico NOTE LEFT0');
				quickAnimAdd('singRIGHTmiss', 'Pico NOTE LEFT miss');
				quickAnimAdd('singLEFTmiss', 'Pico Note Right Miss');
				quickAnimAdd('singUPmiss', 'pico Up note miss', 24);
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS', 24);
							
				playAnim('idle');

				flipX = true;
			case 'bf-pico' | 'bf-pico-car' | 'bf-pico-christmas':
				tex = Paths.getSparrowAtlas('characters/PLAYER_PICO');
				frames = tex;
				quickAnimAdd('idle', "Pico Idle Dance");
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				quickAnimAdd('singLEFT', 'Pico NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'Pico Note Right0');
				quickAnimAdd('singUPmiss', 'pico Up note miss');
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS');
				quickAnimAdd('singRIGHTmiss', 'Pico Note Right Miss');
				quickAnimAdd('singLEFTmiss', 'Pico NOTE LEFT miss');
				quickAnimAdd('firstDeath', "pico dies");
				animation.addByPrefix('deathLoop', "pico dead loop", 24, true);
				quickAnimAdd('deathConfirm', "pico dead confirm");
				quickAnimAdd('hey', "PICO HEY LOL");
				quickAnimAdd('scared', "Pico Scared");
				
				playAnim('idle');

				flipX = true;
			case 'bf-bloops-dead':
				tex = Paths.getSparrowAtlas('characters/BloopsDead');
				frames = tex;
				
				quickAnimAdd('idle', 'Bloops Dead0001');
				quickAnimAdd('firstDeath', 'Bloops Dead0');
				animation.addByPrefix('deathLoop', 'Bloops Dead loop', 24, true);
				quickAnimAdd('deathConfirm', 'Bloops Dead0041');
				
				playAnim('firstDeath');
				flipX = true;
			case 'bf-bloops-dead-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/BSidesBloopsDead');
				frames = tex;
				
				quickAnimAdd('idle', 'Bloops Dead0001');
				quickAnimAdd('firstDeath', 'Bloops Dead0');
				animation.addByPrefix('deathLoop', 'Bloops Dead loop', 24, true);
				quickAnimAdd('deathConfirm', 'Bloops Dead0041');
				
				playAnim('firstDeath');
				
				flipX = true;
			case 'bf-bloops':
				tex = Paths.getSparrowAtlas('characters/Bloops');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');
				quickAnimAdd('hey', 'Peace');
				quickAnimAdd('scared', 'Scared');

				playAnim('idle');
				
				flipX = true;
				
			case 'bf-bloops-christmas':
				tex = Paths.getSparrowAtlas('characters/Christmas_Bloops');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');
				quickAnimAdd('hey', 'Peace');
				quickAnimAdd('scared', 'Scared');

				playAnim('idle');
				
				flipX = true;
				
			case 'bf-bloops-car':
				tex = Paths.getSparrowAtlas('characters/BloopCar');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');

				playAnim('idle');
				
				flipX = true;
			
			case 'bf-milne' | 'bf-milne-car' | 'bf-milne-christmas':
				tex = Paths.getSparrowAtlas('characters/milne');
				frames = tex;
				
				quickAnimAdd('idle', 'Milne Idle');
				quickAnimAdd('singUP', 'Milne Up0');
				quickAnimAdd('singRIGHT', 'Milne Right0');
				quickAnimAdd('singLEFT', 'Milne Left0');
				quickAnimAdd('singDOWN', 'Milne Down0');
				quickAnimAdd('singUPmiss', 'Milne Up Fail');
				quickAnimAdd('singRIGHTmiss', 'Milne Right Fail');
				quickAnimAdd('singLEFTmiss', 'Milne Left Fail');
				quickAnimAdd('singDOWNmiss', 'Milne Down Fail');
				quickAnimAdd('hey', 'Milne Crystals');
				quickAnimAdd('scared', 'Milne Scared');
				
				playAnim('idle');
				
				flipX = true;
			case 'bf-dylan' | 'bf-dylan-christmas':
				var tex = Paths.getSparrowAtlas('characters/dylan');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');
				quickAnimAdd('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;
			case 'bf-dylan-car':
				var tex = Paths.getSparrowAtlas('characters/dylan car');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				
				playAnim('idle');

				flipX = true;
			case 'bf-dylan-dead':
				var tex = Paths.getSparrowAtlas('characters/dylandies');
				frames = tex;
				quickAnimAdd('idle', "BF dies");
				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");
				animation.play('firstDeath');

				playAnim('firstDeath');

				flipX = true;
				
			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");

				quickAnimAdd('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');

				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				quickAnimAdd('idle', 'BF IDLE');
				quickAnimAdd('singUP', 'BF UP NOTE');
				quickAnimAdd('singLEFT', 'BF LEFT NOTE');
				quickAnimAdd('singRIGHT', 'BF RIGHT NOTE');
				quickAnimAdd('singDOWN', 'BF DOWN NOTE');
				quickAnimAdd('singUPmiss', 'BF UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF DOWN MISS');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				quickAnimAdd('singUP', "BF Dies pixel");
				quickAnimAdd('firstDeath', "BF Dies pixel");
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				quickAnimAdd('deathConfirm', "RETRY CONFIRM");
				animation.play('firstDeath');

				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				quickAnimAdd('idle', 'Senpai Idle');
				quickAnimAdd('singUP', 'SENPAI UP NOTE');
				quickAnimAdd('singLEFT', 'SENPAI LEFT NOTE');
				quickAnimAdd('singRIGHT', 'SENPAI RIGHT NOTE');
				quickAnimAdd('singDOWN', 'SENPAI DOWN NOTE');


				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				quickAnimAdd('idle', 'Senpai Roses Idle');
				quickAnimAdd('lmao', 'Angry Senpai Idle');
				quickAnimAdd('singUP', 'Angry Senpai UP NOTE');
				quickAnimAdd('singLEFT', 'Angry Senpai LEFT NOTE');
				quickAnimAdd('singRIGHT', 'Angry Senpai RIGHT NOTE');
				quickAnimAdd('singDOWN', 'Angry Senpai DOWN NOTE');
				quickAnimAdd('singUP-alt', 'SENPAI UP NOTE');
				quickAnimAdd('singLEFT-alt', 'SENPAI LEFT NOTE');
				quickAnimAdd('singRIGHT-alt', 'SENPAI RIGHT NOTE');
				quickAnimAdd('singDOWN-alt', 'SENPAI DOWN NOTE');

				playAnim('lmao');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				quickAnimAdd('idle', "idle spirit_");
				quickAnimAdd('singUP', "up_");
				quickAnimAdd('singRIGHT', "right_");
				quickAnimAdd('singLEFT', "left_");
				quickAnimAdd('singDOWN', "spirit down_");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				quickAnimAdd('idle', 'Parent Christmas Idle');
				quickAnimAdd('singUP', 'Parent Up Note Dad');
				quickAnimAdd('singDOWN', 'Parent Down Note Dad');
				quickAnimAdd('singLEFT', 'Parent Left Note Dad');
				quickAnimAdd('singRIGHT', 'Parent Right Note Dad');

				quickAnimAdd('singUP-alt', 'Parent Up Note Mom');

				quickAnimAdd('singDOWN-alt', 'Parent Down Note Mom');
				quickAnimAdd('singLEFT-alt', 'Parent Left Note Mom');
				quickAnimAdd('singRIGHT-alt', 'Parent Right Note Mom');

				playAnim('idle');
				
				//BSIDES CHARS
				
			case 'gf-bsides':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/bsides/GF_assets');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				quickAnimAdd('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			case 'gf-christmas-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/gfChristmas');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				quickAnimAdd('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			case 'gf-car-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				playAnim('danceRight');

			case 'gf-pixel-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad-bsides':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bsides/DADDY_DEAREST');
				frames = tex;
				quickAnimAdd('idle', 'Dad idle dance', 24);
				quickAnimAdd('singUP', 'Dad Sing Note UP', 24);
				quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT', 24);
				quickAnimAdd('singDOWN', 'Dad Sing Note DOWN', 24);
				quickAnimAdd('singLEFT', 'Dad Sing Note LEFT', 24);

				playAnim('idle');
			case 'spooky-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/spooky_kids_assets');
				frames = tex;
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'spooky DOWN note');
				quickAnimAdd('singLEFT', 'note sing left');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				playAnim('danceRight');
				
			case 'spooky-skid':
				tex = Paths.getSparrowAtlas('FX/bsides/Blackout_BSkid');
				frames = tex;
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'spooky DOWN note');
				quickAnimAdd('singLEFT', 'sorry nothing');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				playAnim('danceRight');
				
			case 'mom-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/Mom_Assets');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				playAnim('idle');

			case 'mom-car-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/momCar');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');
				
				playAnim('idle');
			case 'monster-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/Monster_Assets');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				playAnim('idle');
			case 'monster-christmas-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/monsterChristmas');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				playAnim('idle');
			case 'pico-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/Pico_FNF_assetss');
				frames = tex;
				quickAnimAdd('idle', "Pico Idle Dance", 24);
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				quickAnimAdd('singLEFT', 'Pico Note Right0');
				quickAnimAdd('singRIGHT', 'Pico NOTE LEFT0');
				quickAnimAdd('singRIGHTmiss', 'Pico NOTE LEFT miss');
				quickAnimAdd('singLEFTmiss', 'Pico Note Right Miss');
				quickAnimAdd('singUPmiss', 'pico Up note miss', 24);
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS', 24);

							
				playAnim('idle');

				flipX = true;
			case 'bf-pico-bsides' | 'bf-pico-car-bsides' | 'bf-pico-christmas-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/PLAYER_PICO_BSIDES');
				frames = tex;
				quickAnimAdd('idle', "Pico Idle Dance");
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				quickAnimAdd('singLEFT', 'Pico NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'Pico Note Right0');
				quickAnimAdd('singUPmiss', 'pico Up note miss');
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS');
				quickAnimAdd('singRIGHTmiss', 'Pico Note Right Miss');
				quickAnimAdd('singLEFTmiss', 'Pico NOTE LEFT miss');
				quickAnimAdd('firstDeath', "pico dies");
				animation.addByPrefix('deathLoop', "pico dead loop", 24, true);
				quickAnimAdd('deathConfirm', "pico dead confirm");
				quickAnimAdd('hey', "PICO HEY LOL");
				quickAnimAdd('scared', "Pico Scared");

				playAnim('idle');
				
				flipX = true;
				
			case 'bf-bloops-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/BSidesBloops');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');
				quickAnimAdd('hey', 'Peace');
				quickAnimAdd('scared', 'Scared', 24);

				playAnim('idle');
				
				flipX = true;
			
			case 'bf-bloops-christmas-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/Christmas_Bloops');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');
				quickAnimAdd('hey', 'Peace');
				quickAnimAdd('scared', 'Scared', 24);

				playAnim('idle');
				
				flipX = true;
				
			case 'bf-bloops-car-bsides':
				tex = Paths.getSparrowAtlas('characters/bsides/BSidesBloopsCar');
				frames = tex;
				
				quickAnimAdd('idle', 'Idle');
				quickAnimAdd('singUP', 'Up0');
				quickAnimAdd('singRIGHT', 'Left0');
				quickAnimAdd('singLEFT', 'Right0');
				quickAnimAdd('singDOWN', 'Down0');
				quickAnimAdd('singUPmiss', 'Up Miss');
				quickAnimAdd('singRIGHTmiss', 'Left Miss');
				quickAnimAdd('singLEFTmiss', 'Right Miss');
				quickAnimAdd('singDOWNmiss', 'Down Miss');

				playAnim('idle');
				
				flipX = true;
				
			case 'bf-dylan-bsides' | 'bf-dylan-christmas-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/dylan');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');
				quickAnimAdd('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;
				
			case 'bf-dylan-car-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/dylan car');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');

				playAnim('idle');

				flipX = true;
			case 'bf-dylan-dead-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/dylandies');
				frames = tex;
				quickAnimAdd('idle', "BF dies");
				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");

				playAnim('firstDeath');

				flipX = true;
				
			case 'bf-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/BOYFRIEND');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");

				quickAnimAdd('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/bfChristmas');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				playAnim('idle');

				flipX = true;
			case 'bf-car-bsides':
				var tex = Paths.getSparrowAtlas('characters/bsides/bfCar');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				
				playAnim('idle');

				flipX = true;
			case 'bf-pixel-bsides':
				frames = Paths.getSparrowAtlas('characters/bsides/bfPixel');
				quickAnimAdd('idle', 'BF IDLE');
				quickAnimAdd('singUP', 'BF UP NOTE');
				quickAnimAdd('singLEFT', 'BF LEFT NOTE');
				quickAnimAdd('singRIGHT', 'BF RIGHT NOTE');
				quickAnimAdd('singDOWN', 'BF DOWN NOTE');
				quickAnimAdd('singUPmiss', 'BF UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF DOWN MISS');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-bsides-dead':
				frames = Paths.getSparrowAtlas('characters/bsides/bfPixelsDEAD');
				quickAnimAdd('singUP', "BF Dies pixel");
				quickAnimAdd('firstDeath', "BF Dies pixel");
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				quickAnimAdd('deathConfirm', "RETRY CONFIRM");
				animation.play('firstDeath');

				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai-bsides':
				frames = Paths.getSparrowAtlas('characters/bsides/senpai');
				quickAnimAdd('idle', 'Senpai Idle');
				quickAnimAdd('singUP', 'SENPAI UP NOTE');
				quickAnimAdd('singLEFT', 'SENPAI LEFT NOTE');
				quickAnimAdd('singRIGHT', 'SENPAI RIGHT NOTE');
				quickAnimAdd('singDOWN', 'SENPAI DOWN NOTE');

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry-bsides':
				frames = Paths.getSparrowAtlas('characters/bsides/senpai');
				quickAnimAdd('idle', 'Angry Senpai Idle');
				quickAnimAdd('singUP', 'Angry Senpai UP NOTE');
				quickAnimAdd('singLEFT', 'Angry Senpai LEFT NOTE');
				quickAnimAdd('singRIGHT', 'Angry Senpai RIGHT NOTE');
				quickAnimAdd('singDOWN', 'Angry Senpai DOWN NOTE');

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit-bsides':
				frames = Paths.getPackerAtlas('characters/bsides/spirit');
				quickAnimAdd('idle', "idle spirit_");
				quickAnimAdd('singUP', "up_");
				quickAnimAdd('singRIGHT', "right_");
				quickAnimAdd('singLEFT', "left_");
				quickAnimAdd('singDOWN', "spirit down_");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas-bsides':
				frames = Paths.getSparrowAtlas('characters/bsides/mom_dad_christmas_assets');
				quickAnimAdd('idle', 'Parent Christmas Idle');
				quickAnimAdd('singUP', 'Parent Up Note Dad');
				quickAnimAdd('singDOWN', 'Parent Down Note Dad');
				quickAnimAdd('singLEFT', 'Parent Left Note Dad');
				quickAnimAdd('singRIGHT', 'Parent Right Note Dad');

				quickAnimAdd('singUP-alt', 'Parent Up Note Mom');

				quickAnimAdd('singDOWN-alt', 'Parent Down Note Mom');
				quickAnimAdd('singLEFT-alt', 'Parent Left Note Mom');
				quickAnimAdd('singRIGHT-alt', 'Parent Right Note Mom');

				playAnim('idle');

		}
		loadOffsetFile(curCharacter, null);
		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf' | 'gf-bsides':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'mom-car' | 'mom-car-bsides' | 'mom-car-eyes':
				if (animation.curAnim.name == 'idle' && animation.curAnim.finished)
				playAnim('idle',false,false,11);
			case 'bf-car' | 'bf-car-bsides' | 'bf-dylan-car' | 'bf-dylan-car-bsides':
				if ((animation.curAnim.name == 'idle' || animation.curAnim.name.startsWith('sing')) && animation.curAnim.finished)
				playAnim(animation.curAnim.name,false,false,11);
			case 'bf-bloops-car' | 'bf-bloops-car-bsides':
				if ((animation.curAnim.name == 'idle' || animation.curAnim.name.startsWith('sing')) && animation.curAnim.finished)
				playAnim(animation.curAnim.name,false,false,6);
			// THANKS https://github.com/ninjamuffin99/Funkin/pull/239
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gf-bsides' | 'gf-christmas-bsides' | 'gf-car-bsides' | 'gf-pixel-bsides':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky' | 'spooky-bsides' | 'spooky-pump' | 'spooky-skid':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'mom-car' | 'mom-car-bsides' | 'mom-car-eyes':
					if(danced)
						playAnim('idle',true);
					danced = !danced;
				case 'bf-car' | 'bf-car-bsides' | 'bf-bloops-car' | 'bf-bloops-car-bsides' | 'bf-dylan-car' | 'bf-dylan-car-bsides':
					if(!danced)
						playAnim('idle',true);
					danced = !danced;
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf' || curCharacter == 'gf-bsides')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
	function quickAnimAdd(name:String, anim:String, fps:Int = 24)
	{
		animation.addByPrefix(name, anim, fps, false);
	}
	function loadOffsetFile(fileName:String, library:String = null)
	{
		var file:Array<String> = CoolUtil.coolTextFile(Paths.getPath('images/characters/offsets/' + fileName + 'Offsets.txt', TEXT, library));
		for (i in 0...file.length)
		{
			var offset:Array<String> = file[i].split(' ');
			addOffset(offset[0], Std.parseInt(offset[1]), Std.parseInt(offset[2]));
		}
	}
}
