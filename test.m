for i = 1:1080
    for j = 1:1920
        if(just_red(i, j, 1) > 0 && just_red(i, j, 1)!=1)
            just_red(i, j, 1)
        end
    end
end
