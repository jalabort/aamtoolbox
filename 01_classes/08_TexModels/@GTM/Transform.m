function [tex] = Transform(obj,img)
  %Trandform Summary of this function goes here
  %   Detailed explanation goes here
  
  if isempty(obj.smoother)
    tex = obj.TransformWithoutSmoothing(img);
  else
    switch class(obj.smoother)
      case 'S_Gaus'
        img = obj.smoother.Run(img); % matlab allows this and it is faster!!!
        tex = obj.TransformWithoutSmoothing(img);
      case 'S'
        tex = obj.TransformWithSmoothing(img);
    end
  end
  
end

