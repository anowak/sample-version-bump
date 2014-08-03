Sample for pushing changes at the end of Shippable build
========================================================

This sample demonstrates how to commit and push changes to GitHub repository after a
successful Shippable build. The most interesting part is covered by the `bump_version.sh`
script. After modifying the file, the change is committed and then pushed:
  
    printf \
      '{"version": "0.1.%d", "timestamp": "%s"}' \
      "$(date +%s)" "$(date)" > version.json

    git commit version.json -m "[skip ci] Version bump"

    # use the key that Shippable uses to connect to GitHub
    ssh-agent bash -c "ssh-add ~/keys/id_${JOB_ID}; git push"

The commit message begins with `[skip ci]` to prevent this commit from triggering another
Shippable build (otherwise, it would create an infinite loop). The last line here is
temporarily switching to SSH key added by Shippable to your repository.

Please note that you can also add your custom key to GitHub repository, or use the one
provided by Shippable as 'Deployment key' in the web interface. However, GitHub permits
the key to be used only for one repository, so it is advisable to pick some unique key.

To demonstrate that the updated version string is picked up by the application, it is
deployed to Heroku. For more detailed documentation on Heroku deployment, please see Shippable's continuous
deployment section: http://docs.shippable.com/en/latest/config.html#continuous-deployment

This sample is built for Shippable, a docker based continuous integration and deployment platform.
