# Further Plan for the Flower Shower Animation

So right now, we’ve got a single row of flowers floating down the screen as a start while I was on screen share.  
To make it look more natural and less like a single row of flowers,

Here’s what I’m thinking:

- Instead of moving one whole row together, we would animate each flower individually in stack.  
  That way, we can make each one fall at its own speed and from a different position. How the actual shower works.

- We can a create a class to represent a flower — probably would contain like path of image, X position (while falling down), fall speed, and its own animation controller.

- We have to randomize the X position and fall speed (probably), we’ll avoid the uniform look and get something natural.

- I’m planning to use a Stack to position each flower independently and layer them over the background.  
  Each flower will use its own AnimatedBuilder, so they can all animate on their own timelines.

- Disposing is also necessary of each animation controller.

- Recycling flower objects once they’ve finished falling could help in performance optimisation.

- Lastly, if we need a full blown real feeling effect of flower shower, CustomPainter would be the last resort.

As of now, the above done code is just the base that I came up with while on the fly but this can be improved way more with the above points.
