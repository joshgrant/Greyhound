#  Notes

Found out where the real work needs to be done:

1. We have a system
2. Each system has flows and stocks
3. Each system runs the following loop:
    1. Run through each flow
    2. Simulate applying each flow to the system
    3. Find the flow that improves the balance of the system
    4. Actually run that flow
