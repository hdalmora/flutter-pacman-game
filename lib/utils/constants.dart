class WallConstants {
  static const Map<int, String> wallsMap = {
    1: 'wall/wall_up.png',
    2: 'wall/wall_up_close_top.png',
    3: 'wall/wall_up_close_bottom.png',
    4: 'wall/wall_down.png',
    5: 'wall/wall_down_close_right.png',
    6: 'wall/wall_down_close_left.png',
    7: 'wall/wall_side_bottom_left.png',
    8: 'wall/wall_side_bottom_right.png',
    9: 'wall/wall_side_top_left.png',
    10: 'wall/wall_side_top_right.png',
  };
}

enum GhostTypes {
  BLUE,
  LIGHT_BLUE,
  GREEN,
  LIGHT_GREEN,
  PINK,
  RED
}

class GhostConstants {
  static const Map<GhostTypes, String> ghostsMap = {
    GhostTypes.BLUE: 'enemies/ghosts/ghost_blue.png',
    GhostTypes.LIGHT_BLUE: 'enemies/ghosts/ghost_light_blue.png',
    GhostTypes.GREEN: 'enemies/ghosts/ghost_green.png',
    GhostTypes.LIGHT_GREEN: 'enemies/ghosts/ghost_light_green.png',
    GhostTypes.PINK: 'enemies/ghosts/ghost_pink.png',
    GhostTypes.RED: 'enemies/ghosts/ghost_red.png',
  };
}